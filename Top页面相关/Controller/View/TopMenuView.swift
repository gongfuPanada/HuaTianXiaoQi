//
//  TopMenuView.swift
//  HuaTianXiaoQi
//
//  Created by lc－mac on 16/7/6.
//  Copyright © 2016年 lc－mac. All rights reserved.
//

import UIKit


@objc
protocol TopMenuViewDelegate:NSObjectProtocol {
    
    //这里使用的是枚举作为参数  其实就是String
    optional func topMenuView(topMenuView:TopMenuView,selectedTopAction action:TOP10Action.RawValue)
}


///Top 页面顶部的那个View  专栏  作者
class TopMenuView: UIView {
    
    
    ///持有这个代理
    weak var delegate: TopMenuViewDelegate?
    
    /// 标题数组
    var  titles: [String]?
    
    //第一个标题 (专栏)
    var firstTitle:String?{
    
        didSet{
            if let tit = firstTitle{
                articleBtn.setTitle(tit, forState: .Normal)
            }
        }
    }
    
    //第二个标题 (作者)
    var secondTitle:String?{
    
        didSet{
        
            if let tit = secondTitle{
                authorBtn.setTitle(tit, forState: .Normal)
            }
        }
        
    }
    
    //MARK:  懒加载View元素
    ///底部的分割线
    private lazy var underLine:UIView = {
    
        let view = UIView()
        view.backgroundColor = UIColor(gray: 164.0)
        
        return view
    }()
    
    ///作者按钮
    private lazy var authorBtn:UIButton = self.createButton("作者")
    
    ///专栏按钮
    private lazy var articleBtn:UIButton = self.createButton("专栏")
    
    ///底部会滚动的指示线  就是当前页面停留在那个按钮
    private lazy var tipLibne:UIView = {
    
        let view = UIView()
        view.backgroundColor = UIColor.blackColor()
        return view
        
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI(){
    
        addSubview(authorBtn)
        addSubview(articleBtn)
        addSubview(tipLibne)
        addSubview(underLine)
        
        //距离父窗体的左右相同 距离下为-1
        underLine.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.bottom.equalTo(self).offset(-1)
            make.height.equalTo(1)
        }
        //左上和父窗体相同 高度相同 宽度等于 作者按钮的宽度
        articleBtn.snp_makeConstraints { (make) in
            make.top.left.equalTo(self)
            make.height.equalTo(self)
            make.width.equalTo(authorBtn)
        }
        //右上和父窗体相同 左侧紧贴专栏按钮的右侧 尺寸和专栏大小一致
        authorBtn.snp_makeConstraints { (make) in
            make.right.top.equalTo(self)
            make.left.equalTo(articleBtn.snp_right)
            make.size.equalTo(articleBtn)
        }
        
        //计算按钮下面的TipLine应该偏移的X坐标 (屏幕宽度 * 0.5 - 文字的宽度) * 0.5
        let textWidth = (authorBtn.currentTitle! as NSString).boundingRectWithSize(CGSize(width: CGFloat.max, height: CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.init(name: "CODE LIGHT", size: 15)!], context: nil).size.width
        let tipLineLeft = (ScreenWidth * 0.5 - textWidth) * 0.5
        
        //左边偏移 tipLineLeft 库大怒等于专栏按钮中的文字的label的宽度 底部位于分割线有1的顶部,高度为2
        tipLibne.snp_makeConstraints { (make) in
            make.left.equalTo(tipLineLeft)
            make.width.equalTo(articleBtn.titleLabel!)
            make.bottom.equalTo(underLine.snp_top)
            make.height.equalTo(2)
        }
        
    }
    
    
    
    //根据Title创建一个button
    private func createButton(title:String)->UIButton{
    
        let btn = UIButton (title: title, imageName: nil, target: self, selector: #selector(clickbtn(_:)), font: UIFont.init(name: "CODE LIGHT", size: 15)
			, titleColor: UIColor.blackColor())
		return btn
    }
    
    
    func clickbtn(sender:UIButton){
    
        // ALinLog(sender.frame.origin.x)
        
        /*
          点击按钮要做的事情
         1.将指示线的位置移动到当前点击的按钮的下方
         2.播放过渡的动画
            动画做了一个回弹的一个效果
            1.先算出 指示线 的X位置
            2.再进行判断如果X位于屏幕的左侧就给X减去20如果位于右侧就+上30
            3.动画
              1.先到加了30的位置然后在这个动画完成的返回闭包中再执行一个回到真实位置的动画
         */
        
        
		/// 按钮的X+按钮上文字的X
		let orgin_x = sender.frame.origin.x + sender.titleLabel!.frame.origin.x
        
        var move_x = CGFloat(10)
        if orgin_x < ScreenWidth/2{
            move_x = CGFloat(-10)
        }
        
		// 更新位置
		self.tipLibne.snp_updateConstraints { (make) in
			make.left.equalTo(orgin_x+move_x)
		}
        //sender.backgroundColor = UIColor.randomColor(0.1)
		// 加上一个动画效果
     UIView.animateWithDuration(0.4, animations: {

			self.layoutIfNeeded()

		}) { (_) in
			self.tipLibne.snp_updateConstraints { (make) in
				make.left.equalTo(orgin_x)
			}
			// 加上一个动画效果
			UIView.animateWithDuration(0.3) {
				self.layoutIfNeeded()
			}
            //sender.backgroundColor = UIColor.clearColor()
		}

        let selectedTopAction_TOP10Action = sender == authorBtn ? TOP10Action.TopArticleAuthor.rawValue : TOP10Action.TopContents.rawValue
        //执行这个代理
        delegate?.topMenuView!(self, selectedTopAction: selectedTopAction_TOP10Action)
        
        
        /*
         self.tipLine.snp_updateConstraints { (make) in
         make.left.equalTo(left)
         }
         
         UIView.animateWithDuration(0.25) {
         self.layoutIfNeeded()
         }

         }
         */
        
        
        
        
    }
}
