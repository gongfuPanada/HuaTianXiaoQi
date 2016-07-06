//
//  RefreshControl.swift
//  HuaTianXiaoQi
//
//  Created by lc－mac on 16/7/4.
//  Copyright © 2016年 lc－mac. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

///自定义的下拉刷新
class RefreshControl: UIRefreshControl {
    
    
    ///懒加载的自定义刷新控件
    private lazy var tipView : RefershTipView = RefershTipView()
    
    /// 监听frame的变化
    // 是否旋转箭头的标记
    private var rotationFlag = false
    // 是否执行动画的标记
    private var animtoringFlag = false
    // 是否一开始就直接刷新, 没有进行下拉
    private var beginAnimFlag = false
    // 刷新的时候, 不再进行其他操作
    private var isLoading = false
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(tipView)
        
        tipView.snp_makeConstraints { (make) in
            
            make.center.equalTo(self)
            make.size.equalTo(CGSize(width: 200,height: 60))
        }
        //添加观察者  监听frame的变化
        addObserver(self, forKeyPath: "frame", options: .New, context: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit{
        removeObserver(self, forKeyPath: "frame")
    }

     /// 重写监听方法  todo 看不懂
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        let y = frame.origin.y
        // 1. 最开始一进来的时候, 刷新按钮是隐藏的, y就是-64, 需要先判断掉, y>=0 , 说明刷新控件已经完全缩回去了...
        if y >= 0 || y == -64
        {
            return
        }
        
        // 2. 判断是否一进来就进行刷新
        if beginAnimFlag && (y == -60.0 || y == -124.0){
            if !isLoading {
                isLoading = true
                animtoringFlag = true
                tipView.beginLoadingAnimator()
            }
            return
        }
        
        // 3. 释放已经触发了刷新事件, 如果触发了, 需要进行旋转
        if refreshing && !animtoringFlag
        {
            animtoringFlag = true
            tipView.beginLoadingAnimator()
            return
        }
        
        if y <= -50 && !rotationFlag
        {
            rotationFlag = true
            tipView.rotationRefresh(rotationFlag)
        }else if(y > -50 && rotationFlag){
            rotationFlag = false
            tipView.rotationRefresh(rotationFlag)
        }

        
    }
    
    
    ///  重写的停止刷新
    override func endRefreshing() {
        super.endRefreshing()
        
        animtoringFlag = false
        beginAnimFlag = false
        isLoading = false
        
        //用于在制定的时间执行的代码块 但是它这块时间又取得是当前时间,这TM是什么鬼啊 
        //待研究 是否可以直接用主线程更新这块
        //todo
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), { () -> Void in
            self.tipView.stopLoadingAnimator()
        })
        
    }
    

    override func beginRefreshing() {
        super.beginRefreshing()
        ///开始刷新的时候 直接开始菊花转动
        beginAnimFlag = true
    
    }
    
}