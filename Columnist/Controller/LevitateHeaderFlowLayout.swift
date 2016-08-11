//
//  LevitateHeaderFlowLayout.swift
//  HuaTianXiaoQi
//
//  Created by lc－mac on 16/7/14.
//  Copyright © 2016年 lc－mac. All rights reserved.
//

import UIKit

/// 可以让 Header 悬浮的流布局

//这个弄成自适应流布局最好 但它这个不是流布局
class LevitateHeaderFlowLayout: UICollectionViewFlowLayout {
    
   // 重写父类的更新方法
	override func prepareLayout() {
		super.prepareLayout()

		// 永远垂直弹跳
		collectionView?.alwaysBounceVertical = true
		/*一个布尔值，该值指示在滚动时是否头销到集合视图边界的顶部。
		 当这个属性是真的时，节头视图滚动的内容，直到他们达到了屏幕的顶部，在这一点上，他们被固定到集合视图的上限。每一个新的标题视图滚动到屏幕顶部的推钉头视图屏幕之前。
		 此属性的默认值为假。*/
		// 检测当前版本是否为IOS9之后
		if #available(iOS 9.0, *) {

			sectionHeadersPinToVisibleBounds = true

		}
	}
    
    //返回Rect中所有元素的布局属性
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        // 获取父类返回的UIConllectionViewLayoutAttributes数组
        let  answer = super.layoutAttributesForElementsInRect(rect)
        
       // if #available(iOS 9.0, *){}
        //这里不做判断直接返回,因为看不懂作者写的 适配IOS9.0一下版本的代码
        //todo
        return answer
    }
    
  override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {

     //一旦执行滑动 就会调用上面的layoutAttributesForElementsInRect方法
		return true
	}
}