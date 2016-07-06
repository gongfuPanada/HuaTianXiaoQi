//
//  UIColor+Extension.swift
//  HuaTianXiaoQi
//
//  Created by lc－mac on 16/7/4.
//  Copyright © 2016年 lc－mac. All rights reserved.
//

import UIKit


extension UIColor
{
    /**
     根据RGB生成颜色
     
     - parameter r: red
     - parameter g: green
     - parameter b: blue
     
     - returns: 颜色
     */
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
    }
    
    /**
     根据RGB生成颜色
     
     - parameter r: red
     - parameter g: green
     - parameter b: blue
     - parameter alpha: 透明度
     
     - returns: 颜色
     */
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha)
    }
    
    /**
     生成灰色
     
     - parameter gray: 灰色
     
     - returns: 颜色
     */
    convenience init(gray: CGFloat) {
        self.init(red: gray/255.0, green: gray/255.0, blue: gray/255.0, alpha: 1)
    }
    
    
    
    /// 随机生成颜色
     class func randomColor() -> UIColor{
        
        let r = arc4random_uniform(255)
        let g = arc4random_uniform(255)
        let b = arc4random_uniform(255)
        
        return UIColor(r: CGFloat(r), g: CGFloat(g), b: CGFloat(b),alpha: CGFloat(0.5))
    }
    
    
    
}