//
//  CABaseVC.swift
//  CAWeiBoApp
//
//  Created by  HuangCarson on 15/10/27.
//  Copyright © 2015年 HuangCarson. All rights reserved.
//

import UIKit

class CABaseVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //设置内容view
        let contentView = CAContentView()
        view = contentView
 
        
        //设置代理
        contentView.contentViewDelegate = self
        
        if self is CAHomeVC
        {
            //不必调用setUpIconView()就不会隐藏homeView
            //旋转图片
            contentView.iconViewAnimation();
            
            //设置导航栏上的注册和登录按钮
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.Plain, target: self, action: "registerBtnClickAction")
              navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.Plain, target: self, action: "loginBtnClickAction")
        }
        else if self is CADiscoverVC
        {
          contentView.setUpIconView("visitordiscover_image_message", messgae: "登录后，最新、最热微博尽在掌握，不再会与实事潮流擦肩而过")
        }
        else if self is CAMessageVC
        {
            contentView.setUpIconView("visitordiscover_image_message", messgae: "登录后，别人评论你的微博，发给你的消息，都会在这里收到通知")

        }
        else if  self is CAMineVC
        {
             contentView.setUpIconView("visitordiscover_image_profile", messgae: " 登录后，你的微博、相册、个人资料会显示在这里，展示给别人")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}

//MARK:- 类扩展 方便管理
//遵循协议，实现代理方法
extension CABaseVC : CAContentViewDelegate
{
    func loginBtnClickAction() {
        print("\(__FUNCTION__)")
    }
    
    func registerBtnClickAction() {
        print("\(__FUNCTION__)")
    }
}