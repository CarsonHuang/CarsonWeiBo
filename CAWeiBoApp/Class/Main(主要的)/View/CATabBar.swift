//
//  CATabBar.swift
//  CAWeiBoApp
//
//  Created by  HuangCarson on 15/10/26.
//  Copyright © 2015年 HuangCarson. All rights reserved.
//

import UIKit

class CATabBar: UITabBar {

    //设置按钮的个数
    private let count: CGFloat = 5
    
   //布局子控件
    override func layoutSubviews() {
     
        
        super.layoutSubviews()
        
        //设置按钮的位置
        //按钮的宽度
        let width = bounds.width / count
        

        let frame = CGRect(x: 0, y: 0,  width: width, height: bounds.height)
        
        var index:Int = 0
        //subviews父控制器中的子控件
        for  view in subviews
        {
            //判断类型是否为UITabBarButton
            if view is UIControl && !(view is UIButton)
            {
                print("\(index)")
                //计算按钮的偏移值
                view.frame = CGRectOffset(frame, width * CGFloat(index), 0)
                
                index += index == 1 ? 2 : 1
            }
    
        }
        //设置添加按钮的frame
        composButton.frame = CGRectOffset(frame, width * 2, 0)
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
        
        //添加创建的按钮
        self.addSubview(btn)
        
        //返回按钮
        return btn
        
    }()


}





