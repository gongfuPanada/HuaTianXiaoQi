//
//  UIButton+Extension.swift
//  HuaTianXiaoQi
//
//  Created by lc－mac on 16/7/4.
//  Copyright © 2016年 lc－mac. All rights reserved.
//

import UIKit

extension UIButton {

    ///重写UIButton的init 方法
    convenience init(title: String?, imageName: String?, target: AnyObject?, selector: Selector?, font: UIFont?, titleColor: UIColor?){
    
        self.init()
        //设置图片
        if let imageN = imageName{
            
         setImage(UIImage(named: imageN), forState: .Normal)
       
        }
        
        setTitleColor(titleColor, forState: .Normal)
        
        titleLabel?.font = font
        
        setTitle(title, forState: .Normal)
        //设置事件
        if let sel = selector{
            
            addTarget(target, action: sel, forControlEvents: .TouchUpInside)
        }
    
    
    }

}
