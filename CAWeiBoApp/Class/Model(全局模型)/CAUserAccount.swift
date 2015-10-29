//
//  CAUserAccount.swift
//  CAWeiBoApp
//
//  Created by  HuangCarson on 15/10/28.
//  Copyright © 2015年 HuangCarson. All rights reserved.
//

import UIKit

class CAUserAccount: NSObject,NSCoding {

    //借口获取授权后的access token
    var access_token : String?
    //access_token的生命周期，单位秒
    var expires_in : NSTimeInterval = 0 {
        didSet {
            self.expiresDate = NSDate(timeIntervalSinceNow: expires_in)
        }
    }
    //当前授权用户的UID
    var uid : String?
    //过期日期
    var expiresDate: NSDate?
    
    
    //返回的用户数据显示昵称
    var name : String?
    
    //用户头像
    var avatar_large : String?
    

    //字典转模型
    init(dict: [String:AnyObject])
    {
        //重写父类方法
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    //当字典里key在模型中没有对应的属性
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }
    
    //打印数据
    override var description : String
    {
        return "access_token:\(access_token),expires_in:\(expires_in),uid:\(uid),expiresDate:\(expiresDate)"
    }
    
    //MARK:- 实现归档和解档
    func encodeWithCoder(aCoder: NSCoder) {
       
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeDouble(expires_in, forKey:"expires_in")
        aCoder.encodeObject(uid, forKey: "uid")
        aCoder.encodeObject(expiresDate, forKey: "expiresDate")
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(avatar_large, forKey: "avatar_large")
    }
    
    required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObjectForKey("access_token") as? String
        expires_in = aDecoder.decodeDoubleForKey("expires_in")
        uid = aDecoder.decodeObjectForKey("uid") as? String
        expiresDate = aDecoder.decodeObjectForKey("expiresDate") as? NSDate
        name = aDecoder.decodeObjectForKey("name") as? String
        avatar_large  = aDecoder.decodeObjectForKey("avatar_large") as? String
    }
    
    //MARK:-定义归档的沙盒路径
    private  static let accountPath = (NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,NSSearchPathDomainMask.UserDomainMask, true).last! as NSString).stringByAppendingString("Account.plist")
    
    //MARK:-保存账户信息
    func saveAccount()
    {
        //保存到上面的沙盒路径中
        NSKeyedArchiver.archiveRootObject(self, toFile: CAUserAccount.accountPath)
    }
    
    
    //MARK:- 加载用户信息
    func loadUserInfo (finish:((error:NSError?)->()))
    {
        CANetworkTools.instance.loadUserInfo { (result, error) -> () in
            if error == nil || result == nil
            {
                //加载错误
                finish(error: error)
                return
            }
            
            //加载成功 ， 保存属性 ，
            self.name = result!["name"] as? String
            self.avatar_large = result!["avatar_large"] as? String
            
            //保存到沙盒路径
            self.saveAccount()
            // 同步到内存 否则此时内存中的属性还是原来的
            CAUserAccount.userAccount = self
            finish(error: nil)
        }
    }

    
    //类方法访问属性需要将属性定义成static
    private static var userAccount : CAUserAccount?
    //MARK: -加载账号信息
    //由于解档账号耗性能，只加载一次，保存在内存中，访问时在内存中读取
    class  func loadAccount() -> CAUserAccount?
    {
        //判断内存中有没有
        if userAccount == nil
        {
            userAccount = NSKeyedUnarchiver.unarchiveObjectWithFile(accountPath) as? CAUserAccount
        }

        
        // 判断账号是否过期 判断依据： 当前时间大于过期时间
        /**
        *  expiresDate 过期时间
        *  @param NSDate 当前时间
        OrderedAscending <
        OrderedSame  ==
        OrderedDescending >
        */
        if userAccount != nil && userAccount?.expiresDate?.compare(NSDate()) == NSComparisonResult.OrderedDescending{
            
            print("账号有效！")
            return userAccount
        }
        //账号没效，返回nil
        return nil
     }
    
  
}
