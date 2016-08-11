//
//  CollectionViewFlowLayout.swift
//  HuaTianXiaoQi
//
//  Created by lc－mac on 16/7/14.
//  Copyright © 2016年 lc－mac. All rights reserved.
//

import Foundation

///自定义的collectionViewFlowLayout类 继承自自定义的一个那个类 可以让header悬浮  这块可以弄成瀑布流的 todo
class CollectionViewFlowLayout: LevitateHeaderFlowLayout {
    
    
    override func prepareLayout() {
        super.prepareLayout()
        
        //永远都只能在竖直方向滚动
        collectionView?.alwaysBounceVertical = true;
        scrollDirection = .Vertical
        minimumLineSpacing = 5
        
        minimumInteritemSpacing = 0
    }
    
    
}