//
//  UILabel+Extension.swift
//  HuaTianXiaoQi
//
//  Created by lc－mac on 16/8/11.
//  Copyright © 2016年 lc－mac. All rights reserved.
//

import UIKit

extension UILabel{

    ///自己扩展的构造方法 参数 文字的颜色和字体
    convenience init(textColor:UIColor,font:UIFont){
        //在这块直接调用默认的构造函数创建出一个label 再给这个label赋值
        self.init()
        
        self.font = font
        
        self.textColor = textColor
        
    }
}