//
//  CAContentView.swift
//  CAWeiBoApp
//
//  Created by  HuangCarson on 15/10/27.
//  Copyright © 2015年 HuangCarson. All rights reserved.
//

import UIKit

//MARK:- 创建代理协议
protocol CAContentViewDelegate : NSObjectProtocol
{
    //创建代理方法
    func registerBtnClickAction()
    func loginBtnClickAction()
}


class CAContentView: UIView {
    
    //代理属性
    weak var contentViewDelegate : CAContentViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(white: 237/255, alpha: 1)
        addSubview(iconView)
        //添加遮盖到转盘的上方，屋子图片的下方
        addSubview(converView)
        addSubview(homeView)
        addSubview(labContent)
        addSubview(loginBtn)
        addSubview(registerBtn)
        
        setUp()
        
    }
    
    //创建iconView旋转的方法
    func iconViewAnimation()
    {
        //创建核心动画
        let  animation = CABasicAnimation(keyPath: "transform.rotation")
        
        //旋转的值 旋转一圈
        animation.toValue = 2 * M_PI
        //设置动画时间
        animation.duration = 20
        //设置播放次数
        animation.repeatCount = MAXFLOAT
        //添加核心动画到iconView
        iconView.layer.addAnimation(animation, forKey: nil)
    }
    
    //设置每个控制器中间的图片
    func setUpIconView(imgName : String , messgae : String )
    {
        //设置iconView的图片和labContent内容
      iconView.image = UIImage(named: imgName)
      labContent.text = messgae
      labContent.sizeToFit()
        //隐藏homeView
        homeView.hidden = true
    
    }
    
    func setUp()
    {
        //设置布局
        //取消自动布局
        iconView.translatesAutoresizingMaskIntoConstraints = false
        homeView.translatesAutoresizingMaskIntoConstraints = false
        labContent.translatesAutoresizingMaskIntoConstraints = false
        loginBtn.translatesAutoresizingMaskIntoConstraints = false
        registerBtn.translatesAutoresizingMaskIntoConstraints = false
        
        converView.translatesAutoresizingMaskIntoConstraints = false
        
        //约束iconView
        addConstraint(NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: -50))
        
        //约束homeView
        addConstraint(NSLayoutConstraint(item: homeView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: homeView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0))
        
        //约束消息内容
        addConstraint(NSLayoutConstraint(item: labContent, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 224))
        addConstraint(NSLayoutConstraint(item: labContent, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: labContent, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 16))
        
        //约束注册按钮
        addConstraint(NSLayoutConstraint(item: registerBtn, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: labContent, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: registerBtn, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: labContent, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 16))
        addConstraint(NSLayoutConstraint(item: registerBtn, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 100))
        addConstraint(NSLayoutConstraint(item: registerBtn, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 30))
        
        //约束登录按钮
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: labContent, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: registerBtn, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 100))
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 30))
        
//        约束遮盖部分
        addConstraint(NSLayoutConstraint(item: converView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: converView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: converView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: registerBtn, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0))
   
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK:- 懒加载控件
    lazy var iconView : UIImageView = {
    
        let img = UIImageView()
        
        img.image = UIImage(named: "visitordiscover_feed_image_smallicon")
        
        //sizeToFit 根据内容自动设置控件大小
        img.sizeToFit()
        
        return img
    }()
    
    //屋子图片
    lazy var homeView : UIImageView =
    {
        let img = UIImageView()
        img.image = UIImage(named: "visitordiscover_feed_image_house")
        img.sizeToFit()
        return img
    }()

    //内容
    lazy var labContent : UILabel = {
        let lab = UILabel()
        
        lab.text = "风萧萧兮易水寒，壮士一去兮不复还。风萧萧兮易水寒，壮士一去兮不复还。风萧萧兮易水寒，壮士一去兮不复还。"
        lab.textColor = UIColor.lightGrayColor()
        //换行
        lab.numberOfLines = 0;
        lab.sizeToFit()
        return lab
    }()
    
    //登录按钮
    lazy var loginBtn : UIButton = {
        let btn = UIButton()
        
        btn.setTitle("登录", forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        //设置登录按钮的监听
        btn.addTarget(self, action: "loginBtnClickAction", forControlEvents: UIControlEvents.TouchUpInside)
        return btn
    }()
    
    //注册按钮
    lazy var  registerBtn : UIButton = {
        let  btn = UIButton()
        
        btn.setTitle("注册", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
       btn.setBackgroundImage(UIImage(named:  "common_button_white_disable"), forState: UIControlState.Normal)
        //设置注册按钮的监听
        btn.addTarget(self, action: "registerBtnClickAction", forControlEvents: UIControlEvents.TouchUpInside)
        return btn
    }()
    
    
    //遮盖
    lazy var converView : UIImageView = {
        let img = UIImage(named: "visitordiscover_feed_mask_smallicon")
        
        return UIImageView(image: img)
    }()
    
    
   
    func loginBtnClickAction() {
        print("点击了登录按钮")
    }
    func registerBtnClickAction() {
        print("点击了注册按钮")
    }
}

    