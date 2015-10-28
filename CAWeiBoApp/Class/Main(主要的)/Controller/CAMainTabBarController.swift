//
//  CAMainTabBarController.swift
//  CAWeiBoApp
//
//  Created by  HuangCarson on 15/10/26.
//  Copyright © 2015年 HuangCarson. All rights reserved.
//

import UIKit

class CAMainTabBarController: UITabBarController {
    
    func composButtonAction()
    {
        print("哈哈")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let newTabBar =  CATabBar()
//        
//        newTabBar.composButton.addTarget(self, action:"composButtonAction" , forControlEvents: UIControlEvents.TouchUpInside)
//
//        setValue(newTabBar, forKey: "tabBar")
        
        
        //设置按钮的颜色
        tabBar.tintColor = UIColor.orangeColor()
        
        //首页控制器
        let homeVC = CAHomeVC()
        addChildViewController(homeVC, title: "首页", ImgName: "tabbar_home")

        //消息控制器
        let messageVC = CAMessageVC()
        addChildViewController(messageVC, title: "消息", ImgName: "tabbar_message_center")
        
        //添加一个空的viewController为按钮占位
        let nilVC = UIViewController()
        addChildViewController(nilVC, title: "", ImgName: "")
        
        //发现控制器
        let discoverVC = CADiscoverVC()
        addChildViewController(discoverVC, title: "发现", ImgName: "tabbar_discover")
        
        //我控制器
        let mineVC = CAMineVC()
        addChildViewController(mineVC, title: "我", ImgName: "tabbar_profile")
    
    }
    
    //MARK:- 创建方法添加自控制器
    private func  addChildViewController(vc: UIViewController, title: String ,ImgName: String ) {
        //设置控制器的头部文字，切换控制器按钮颜色
        vc.title = title
        vc.tabBarItem.image = UIImage(named: ImgName)
        //将控制器添加到导航控制器，再添加到UITabBarController
        addChildViewController(UINavigationController(rootViewController: vc))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let width = tabBar.bounds.width / CGFloat(5)
        composButton.frame = CGRect(x: width * 2, y: 0, width: width, height: tabBar.bounds.height)
        tabBar.addSubview(composButton)
    }
    
    //MARK:- 懒加载
    lazy var composButton : UIButton = {
        
        let btn = UIButton()
        
        //设置按钮图片
        btn.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: UIControlState.Normal)
        btn.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: UIControlState.Highlighted)
        
        //设置按钮背景图片
        btn.setBackgroundImage(UIImage(named:  "tabbar_compose_button"), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: UIControlState.Highlighted)
        
        btn.addTarget(self, action: "composButtonAction", forControlEvents: UIControlEvents.TouchUpInside)
        
        //返回按钮
        return btn
        
        }()
    
    
}

