//
//  AppDelegate.swift
//  CAWeiBoApp
//
//  Created by  HuangCarson on 15/10/26.
//  Copyright © 2015年 HuangCarson. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
        //创建window
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        window?.rootViewController = CAMainTabBarController()
        
        //设置全局导航栏的字体颜色为橘色
        UINavigationBar.appearance().tintColor = UIColor.orangeColor()
        
        //设置为主界面并且显示
        window?.makeKeyAndVisible()
        
        return true
    }
    
    
    
 }

