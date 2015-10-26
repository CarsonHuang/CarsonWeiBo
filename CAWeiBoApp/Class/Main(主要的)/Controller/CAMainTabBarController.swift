//
//  CAMainTabBarController.swift
//  CAWeiBoApp
//
//  Created by  HuangCarson on 15/10/26.
//  Copyright © 2015年 HuangCarson. All rights reserved.
//

import UIKit

class CAMainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //首页控制器
        let homeVC = CAHomeVC()
        addChildViewController(homeVC, title: "首页", ImgName: "tabbar_home")

        //消息控制器
        let messageVC = CAMessageVC()
        addChildViewController(messageVC, title: "消息", ImgName: "tabbar_message_center")
        
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


}
