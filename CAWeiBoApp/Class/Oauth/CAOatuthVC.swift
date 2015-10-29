//
//  CAOatuthVC.swift
//  CAWeiBoApp
//
//  Created by  HuangCarson on 15/10/28.
//  Copyright © 2015年 HuangCarson. All rights reserved.
//

import UIKit
import SVProgressHUD

class CAOatuthVC: UITableViewController {

    override func loadView() {
        view = webView
        //设置代理
        webView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: "close")
        
        //加载页面 从工具类中获取授权地址
        let request = NSURLRequest(URL: CANetworkTools.instance.OatuhURL())
        webView.loadRequest(request)
        
    }
    
    func close()
    {
        //移除栈顶控制器
        dismissViewControllerAnimated(true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- 懒加载webView
    private lazy var webView = UIWebView()
}

//类扩展 事项UIWebViewDelegate协议
extension CAOatuthVC : UIWebViewDelegate
{
    //开始加载请求
    func webViewDidStartLoad(webView: UIWebView) {
        //显示正在加载
        //调用第三方框架显示
        SVProgressHUD.showWithStatus("正在飞速加载", maskType: SVProgressHUDMaskType.Black)
    }
    
    //加载请求完毕
    func webViewDidFinishLoad(webView: UIWebView) {
        //关闭
        SVProgressHUD.dismiss()
    }
    
    //询问是否加载
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        //接受返回的地址
        let  urlString = request.URL!.absoluteString
        print("urlString:\(urlString)")
        
        //判断回调的是否回调地址
        //依据：是否是回调地址开头的网络路径
        if !urlString.hasPrefix(CANetworkTools.instance.redirect_uri)
        {
            //可以加载
            return true
        }
        
        //点击取消
//        http://www.baidu.com/?error_uri=%2Foauth2%2Fauthorize&error=access_denied&error_description=user%20denied%20your%20request.&error_code=21330
        //点击确定
//        http://www.baidu.com/?code=8b56fa06bebf7dc058696c2b2897767e
        //如果点击的是确定或者取消拦截加载，直到授权才加载
        if let query = request.URL?.query
        {
            print("query:\(query)")
        
            //设置点击确定开头
            let codeStr = "code="
        
            //hasPrefix 判断以什么开头
            if query.hasPrefix(codeStr)
            {
                //确定
                //转换成NSString
                let nsQuery = query as NSString
                
                //获取code的值,从code=开头截取
                let code = nsQuery.substringFromIndex(codeStr.characters.count)
                print("code:\(code)")
                //获取access token
                loadAccessToken(code)
            }else
            {
                //取消
            }
        }
        return false

    }
    
    
    //利用网络工具去加载access Token
    func loadAccessToken(code: String)
    {
        CANetworkTools.instance.loadAccessToken(code) { (result, error) -> () in
            //判断是否报错
            if error != nil || result == nil
            {
                self.showError("网络不给力啊！亲")
                return
            }
         
            print("result:\(result)")
            //返回的result 转换模型
            let account = CAUserAccount(dict: result!)
            print("account:\(account)")
            //保存账户信息
            account.saveAccount()
            
            SVProgressHUD.dismiss()

            //加载用户数据
            account.loadUserInfo({ (error) -> () in
                if error != nil{
                   self.showError("加载用户信息失败！")
                    return
                }
                print("CAUserAccount:\(CAUserAccount.loadAccount())")
                self.close()
            })
            
        }
    }
    
    func  showError(error: String )
    {
        //利用第三方框架显示错误
        SVProgressHUD.showErrorWithStatus(error, maskType: SVProgressHUDMaskType.Black)
        
        //由于平常的报错只显示2秒左右，所以使用延迟
        dispatch_after( dispatch_time(DISPATCH_TIME_NOW, (Int64)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), { () -> Void in
            self.close()
        })
    }
}




