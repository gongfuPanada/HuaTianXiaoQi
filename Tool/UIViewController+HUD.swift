//
//  UIViewController+HUD.swift
//  HuaTianXiaoQi
//
//  Created by lc－mac on 16/6/29.
//  Copyright © 2016年 lc－mac. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

///应用程序的关键窗口
let keyWindow:UIWindow = UIApplication.sharedApplication().keyWindow!

private var HUDKey = "HUDKey"

extension UIViewController{
    
    ///我操 神代码!!! 用oc 动态绑定的方法给 定义一个 hud 之后通过set方法给这个hud赋值来实现不同的属性  保证了唯一性 还是动态的  屌  todo
      var hud:MBProgressHUD?{
    
        get{
            
         return objc_getAssociatedObject(self, &HUDKey) as? MBProgressHUD
        }
        
        set{
            
            objc_setAssociatedObject(self, &HUDKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    
    
    /**
     显示纯文字提示信息(显示在keywindow上)
     
     - parameter hint: 提示信息
     - parameter duration: 持续时间(不填的话, 默认两秒)
     - parameter yOffset: y上的偏移量
     */
    func showHint(hint:String,duration:Double?,yOffset:Float?){
        //这块为什么要拿当前的关键window??? todo
        let view = keyWindow
        let HUD = MBProgressHUD(view: view)
        view.addSubview(HUD)
        HUD.userInteractionEnabled = false
        HUD.mode = .Text
        HUD.labelText = hint
        //当Y轴的偏移为空时取0
        HUD.yOffset = yOffset ?? 0
        HUD.show(true)
        HUD.removeFromSuperViewOnHide = false
        //持续时间为空时取2
        HUD.hide(true, afterDelay: duration ?? 2)
        hud = HUD


    }
    
    /**
     显示纯文字提示信息
     
     - parameter hint: 显示在哪个View上
     - parameter hint: 提示信息
     - parameter duration: 持续时间(不填的话, 默认两秒)
     - parameter yOffset: y上的偏移量
     */
    func showHint(view: UIView, hint: String, duration: Double?, yOffset:Float?) {
        let HUD = MBProgressHUD(view: view)
        view.addSubview(HUD)
        HUD.userInteractionEnabled = false
        HUD.mode = .Text
        HUD.labelText = hint
        //当Y轴的偏移为空时取0
        HUD.yOffset = yOffset ?? 0
        HUD.show(true)
        HUD.removeFromSuperViewOnHide = false
        //持续时间为空时取2
        HUD.hide(true, afterDelay: duration ?? 2)
        hud = HUD
    }
    
    ///隐藏hud
    func hideHud() {
        hud!.hide(true)
     }

    
}