
//
//  RefershTipView.swift
//  HuaTianXiaoQi
//
//  Created by lc－mac on 16/7/4.
//  Copyright © 2016年 lc－mac. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

///刷新的提示界面
class RefershTipView: UIView {

	// 箭头
	let arrowView: UIImageView = {
		let arrow = UIImageView(image: UIImage(named: "tableview_pull_refresh"))
		return arrow
	}()
	/// 提示文字
	let tipLabel: UILabel = {
		let tip = UILabel()
		tip.font = UIFont(name: "CODE LIGHT", size: 14)
		tip.text = "下拉刷新"
		return tip
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)

		backgroundColor = UIColor.whiteColor()
        
        setupUI()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
    ///设置UI
	func setupUI() {

		addSubview(arrowView)
		addSubview(tipLabel)

		arrowView.snp_makeConstraints { (make) in
			make.centerX.equalTo(self).offset(-40)
			make.centerY.equalTo(self)
		}

		tipLabel.snp_makeConstraints { (make) in
			make.left.equalTo(arrowView.snp_right).offset(20)
			make.centerY.equalTo(arrowView)
		}

	}
    
    ///旋转箭头, 改变文字
    func rotationRefresh(flag:Bool){
        
        // transfrom的旋转默认是顺时针旋转
        // 如果设置了旋转的角度, 默认是就近原则, 离那边近, 就从哪个方向转
        let angle = flag ? -0.01 : 0.01
        UIView.animateWithDuration(0.5) { 
            
            self.arrowView.transform = CGAffineTransformRotate(self.arrowView.transform, CGFloat(angle + M_PI))
            
            self.tipLabel.text = flag ? "释放刷新" : "下拉刷新"
        }
    
    }
    
    ///开始加载数据 + 转动菊花图
    func  beginLoadingAnimator(){
        
        tipLabel.text = "正在加载..."
        arrowView.image = UIImage(named: "tableview_loading")
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.repeatCount = MAXFLOAT
        anim.repeatCount = MAXFLOAT
        anim.duration = 0.25
        anim.toValue = 2 * M_PI
        // 默认removedOnCompletion后就会移除动画
        anim.removedOnCompletion = false
        arrowView.layer.addAnimation(anim, forKey: nil)

    }
    
    func stopLoadingAnimator(){
    
        tipLabel.text = "停止刷新"
        arrowView.image = UIImage(named: "tableview_pull_refresh")
        //移除所有动画
        arrowView.layer.removeAllAnimations()
    }
}
