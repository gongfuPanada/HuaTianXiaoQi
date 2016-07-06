//
//  UIView+Extension.swift
//  HuaTianXiaoQi
//
//  Created by lc－mac on 16/7/5.
//  Copyright © 2016年 lc－mac. All rights reserved.
//

import Foundation
import UIKit

extension UIView
{
    /// 给这个UIView 加上随机的背景颜色  这里不需要用类方法 因为类方法没有实例
    func setBackGroundColorForRandomColor(){
    
       self.backgroundColor = UIColor.randomColor()
    }
}