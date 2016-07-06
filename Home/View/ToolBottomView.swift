//
//  ToolBottomView.swift
//  HuaTianXiaoQi
//
//  Created by lc－mac on 16/7/4.
//  Copyright © 2016年 lc－mac. All rights reserved.
//

import UIKit
import SnapKit


/// 按钮button的枚举
enum ToolBarBtnType:Int {
    ///查看数
    case See
    ///点赞数
    case Zan
    ///评论
    case Comment
    
}

/// 自定义的Cell的底部View
class ToolBottomView: UIView {
    
    // MARK: - 懒加载
    
    /// 查看数
    private lazy var seeBtn: UIButton = self.createBtn("hp_count")
    /// 评论数
    private lazy var commentBtn: UIButton = self.createBtn("p_comment")
    
    /// 点赞数
    private lazy var zanBtn: UIButton = self.createBtn("p_zan")
    /// 时间
    private lazy var timeBtn: UIButton =  self.createBtn("ad_time")

    
    ///数据源
    var article: Article?{
        didSet{
            seeBtn .setTitle("\(article!.read)", forState: .Normal)
            commentBtn.setTitle("\(article!.fnCommentNum)", forState: .Normal)
            zanBtn.setTitle("\(article!.favo)", forState: .Normal)
            
            if article!.isNotHomeList{
                
                if let time = article!.createDateDesc{
                    timeBtn.hidden = false
                    timeBtn.setTitle(time, forState: .Normal)
                    commentBtn.userInteractionEnabled = true
                }else{
                     timeBtn.hidden = false
                }
            }
            else{
                timeBtn.hidden = true
            }

            
        }
    }
    
    ///持有一个代理
    weak  var delegate: ToolBottomViewDelegate?
    
    
     override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func createBtn(imageName: String)->UIButton{
    
          let btn = UIButton(title: "10", imageName: imageName, target: nil, selector: nil, font:UIFont.systemFontOfSize(12) , titleColor: UIColor.blackColor().colorWithAlphaComponent(0.5))
        
          ///译：一个布尔值，它决定了是否用户触发的事件被该视图对象忽略和把该视图对象从事件响应队列中移除。
          // todo
          btn.userInteractionEnabled = false
          btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10)
          btn.addTarget(self, action: #selector(ToolBottomView.click(_:)), forControlEvents: .TouchUpInside)
          return btn
     }
    
    // 点击事件
    func click(btn: UIButton) {
        if btn == seeBtn {
            delegate?.toolBottomView!(self, type: ToolBarBtnType.See.rawValue)
        }else if(btn == zanBtn){
            delegate?.toolBottomView!(self, type: ToolBarBtnType.Zan.rawValue)
        }else if(btn == commentBtn){
            delegate?.toolBottomView!(self, type: ToolBarBtnType.Comment.rawValue)
        }
    }
    
    
    ///设置界面
    func  setUpUI(){
    
        addSubview(seeBtn)
        addSubview(commentBtn)
        addSubview(zanBtn)
        addSubview(timeBtn)
        
        
        commentBtn.snp_makeConstraints { (make) in
            make.right.equalTo(self).offset(-20)
            make.centerY.equalTo(self)
        }
        
        zanBtn.snp_makeConstraints { (make) in
            make.right.equalTo(commentBtn.snp_left).offset(-10)
            make.centerY.equalTo(self)
        }
        
        seeBtn.snp_makeConstraints { (make) in
            make.right.equalTo(zanBtn.snp_left).offset(-10)
            make.centerY.equalTo(self)
        }
        
        timeBtn.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(20)
            make.centerY.equalTo(self)
        }

    }
    
}


/// 协议
@objc
protocol ToolBottomViewDelegate: NSObjectProtocol {
    
    optional  func toolBottomView(toolBottomView:ToolBottomView,type:ToolBarBtnType.RawValue)
}

