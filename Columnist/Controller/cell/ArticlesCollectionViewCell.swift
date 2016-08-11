//
//  ArticlesCollectionViewCell.swift
//  HuaTianXiaoQi
//
//  Created by lc－mac on 16/8/11.
//  Copyright © 2016年 lc－mac. All rights reserved.
//

import UIKit

///文章的格子
class ArticlesCollectionViewCell: UICollectionViewCell {
    
    ///Cell的数据源
    var article:Article?{
    
        didSet{
        
            if let art = article{
            
                //数据源改变且为真
                let imgUrl = NSURL(string: art.smallIcon!)
                
                thumbnail.kf_setImageWithURL(imgUrl!, placeholderImage: UIImage(named: "placehodler"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                
                nameLabel.text = art.title
                descLabel.text = art.desc
                zanBtn.setTitle(String(art.favo), forState: .Normal)
                seeBtn.setTitle(String(art.read), forState: .Normal)
                
            }
        }
    }
    
    //MARK: 懒加载控件
    ///缩略图
    private lazy var thumbnail = UIImageView();
    ///标题
    private lazy var nameLabel = UILabel(textColor: UIColor.lightGrayColor(), font: UIFont.systemFontOfSize(13))
    ///描述信息
    private lazy var descLabel = UILabel(textColor: UIColor.lightGrayColor(), font: UIFont.systemFontOfSize(11))
    ///分割线 其实就是一个Image控件
    private lazy var underLine = UIImageView(image: UIImage(named: "underLine"))
    ///赞
    private lazy var zanBtn:UIButton = self.createButton("p_zan")
    ///查看
    private lazy var seeBtn:UIButton = self.createButton("hp_count")
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
      
    //MARK: 私有
    private func setUp(){
    
        //底色
        self.contentView.backgroundColor = UIColor.whiteColor()
        //将控件贴上
        contentView.addSubview(thumbnail)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descLabel)
        contentView.addSubview(underLine)
        contentView.addSubview(zanBtn)
        contentView.addSubview(seeBtn)
        
        thumbnail.snp_makeConstraints { (make) in
            
            make.left.top.right.equalTo(contentView)
            make.height.equalTo(140)
        }
        //左右分别间距10 居于缩略图地下10
        nameLabel.snp_makeConstraints { (make) in
            
            make.left.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
            make.top.equalTo(thumbnail.snp_bottom).offset(10)
        }
        
        descLabel.snp_makeConstraints { (make) in
            
            make.left.right.equalTo(contentView)
            make.top.equalTo(nameLabel.snp_bottom).offset(5)
        }
        
        underLine.snp_makeConstraints { (make) in
            
            make.left.equalTo(contentView).offset(5)
            make.right.equalTo(contentView).offset(-5)
            make.height.equalTo(1)
            make.top.equalTo(descLabel.snp_bottom).offset(15)
        }
        
        zanBtn.snp_makeConstraints { (make) in
            
            make.left.equalTo(underLine).offset(5)
            make.width.equalTo(contentView).multipliedBy(0.4)
            make.top.equalTo(underLine.snp_bottom).offset(5)
            
        }

		seeBtn.snp_makeConstraints { (make) in
			make.left.equalTo(contentView.snp_centerX).multipliedBy(0.8)
			make.width.top.equalTo(zanBtn)
		}
        
        
        
        
    }
    
    
    
    
    /// return 一个button 的方法
    private  func createButton(imageName:String)->UIButton{
    
        let btn = UIButton(title: nil, imageName: imageName, target: nil, selector: nil, font: UIFont.systemFontOfSize(11), titleColor: UIColor.lightGrayColor())
        ///button的内容水平 居中
        btn.contentHorizontalAlignment = .Center
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        ///关闭这个属性 表示不触发这个button的事件 或者是事件不传递到视图中
        btn.userInteractionEnabled = false
        return btn
        
    }
    
    
}
