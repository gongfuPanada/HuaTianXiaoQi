//
//  TitleButton.swift
//  HuaTianXiaoQi
//
//  Created by lc－mac on 16/7/5.
//  Copyright © 2016年 lc－mac. All rights reserved.
//

import UIKit


///导航顶部中间的按钮
class TitleButton: UIButton {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //构造这个button
        setTitle("主题", forState: .Normal)
        setImage(UIImage(named: "hp_arrow_down"), forState: .Normal)
        setImage(UIImage(named: "hp_arrow_up"), forState: .Selected)
        setTitleColor(UIColor.blackColor(), forState: .Normal)
        titleLabel?.font = UIFont.systemFontOfSize(15)
        sizeToFit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
     1、init初始化不会触发layoutSubviews
     
     2、addSubview会触发layoutSubviews
     
     3、设置view的Frame会触发layoutSubviews，当然前提是frame的值设置前后发生了变化
     
     4、滚动一个UIScrollView会触发layoutSubviews
     
     5、旋转Screen会触发父UIView上的layoutSubviews事件
     
     6、改变一个UIView大小的时候也会触发父UIView上的layoutSubviews事件
     
     应该是牵扯到布局的时候回调用这个方法
     */
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        //todo
        //这块到底是要调整什么!!!
        if imageView?.frame.origin.x < titleLabel?.frame.origin.x{
        
            titleLabel?.frame.origin.x = imageView!.frame.origin.x
            
            imageView?.frame.origin.x = CGRectGetMaxX(titleLabel!.frame) + 10
        }
        
    }
}
