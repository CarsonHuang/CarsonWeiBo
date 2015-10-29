//
//  CANetworkTools.swift
//  CAWeiBoApp
//
//  Created by  HuangCarson on 15/10/28.
//  Copyright © 2015年 HuangCarson. All rights reserved.
//

import UIKit
import AFNetworking

//class CANetworkTools: AFHTTPSessionManager
//减少对AFHTTPSessionManager的依赖，继承改为NSObject
class CANetworkTools: NSObject
{
    //创建AFN属性
    private var afnManager = AFHTTPSessionManager()

    //CANetworkTools工具类的单例
    static let  instance : CANetworkTools = CANetworkTools()
    override init() {
        super.init()
        
        afnManager = AFHTTPSessionManager(baseURL:NSURL(string: "https://api.weibo.com/"))
      
        //添加text/plain 格式
     afnManager.responseSerializer.acceptableContentTypes?.insert("text/plain")
    }
    
    
    //MARK:- OAtuh授权所需参数
    //AppKey
    private let client_id = "3928105110"
    //申请应用时分配的AppSecret
    private let client_secret = "978d8a2f9ecef2982fd90b124898ec1d"
    
    //请求的类型 
    private let grant_type = "authorization_code"

    //回调地址
    let redirect_uri = "http://www.baidu.com/"
    
    //Oatuh地址
    func OatuhURL() -> NSURL
    {
        //请求
//        https://api.weibo.com/oauth2/authorize?client_id=3928105110&redirect_uri=http://www.baidu.com/
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(client_id)&redirect_uri=\(redirect_uri)"
        return NSURL(string: urlString)!
    }
    
    //使用闭包回调
    //MARK:-加载AccessToken
    //AnyObject 任何类class
    func loadAccessToken(code: String ,finshed :(result:[String:AnyObject]?,error:NSError?)->())
    {
        //url
        let urlString = "oauth2/access_token"
        
        //加载AccessToken POST请求 所需的请求参数
        let parameters = [
            "client_id" : client_id,
            "client_secret" : client_secret,
            "grant_type" : grant_type,
            "code" : code,
            "redirect_uri" : redirect_uri,
        ]
        
        //result 请求结果
        //返回成功信息
        afnManager.POST(urlString, parameters: parameters, success: { (_,result) -> Void in
             finshed(result: result as? [String : AnyObject], error: nil)
            }) { (_,error:NSError) -> Void in
                finshed(result: nil, error: error)
                print("error:------\(error)")
        }
    }
    
    
    //获取返回的用户数据 只管接受
    func loadUserInfo(finshed:(result:[String: AnyObject]?,error:NSError?)->())
    {
        //判断access token是否存在
        if CAUserAccount.loadAccount()?.access_token == nil
        {
            print("access token不存在！")
            return
        }
    
        
        //判断uid是否存在
        if CAUserAccount.loadAccount()?.uid == nil
        {
            print("uid不存在！")
            return
        }
        
        //接口地址
        let urlStr = "https://api.weibo.com/2/users/show.json"
        
        //请求参数
        let params = ["access_token":CAUserAccount.loadAccount()!.access_token!,"uid":CAUserAccount.loadAccount()!.uid!]
        
        
        requestGet(urlStr, params: params, finshed: finshed)
    }
    
    
    //封装AFN的GET方法
    func requestGet(urlStr:String,params:AnyObject?,finshed:(result:[String:AnyObject]?,error:NSError?)->())
    {
        //只有get请求方法
        afnManager.GET(urlStr, parameters:params, success: { (_,result) -> Void in
            finshed(result: result as? [String : AnyObject], error: nil)
            }) { (_,error:NSError) -> Void in
                finshed(result: nil, error: error)
                print("error:------\(error)")
        }

    }
    
    
}
