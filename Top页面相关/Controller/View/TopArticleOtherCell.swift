//
//  TopArticleOtherCell.swift
//  HuaTianXiaoQi
//
//  Created by lc－mac on 16/7/6.
//  Copyright © 2016年 lc－mac. All rights reserved.
//

import Foundation

///专栏的其他格子
class TopArticleOtherCell: TopArticleCell {
    
    ///Logo
    private lazy var logoView = UIImageView(image: UIImage(named: "f_top"))
    
    //重写父类的方法
    override func setUpUI() {
        super.setUpUI()
        
        
        
        //比 1-3  多了一个logo
        contentView.addSubview(smallIconView)
        smallIconView.addSubview(coverView)
        contentView.addSubview(logoView)
        logoView.addSubview(sortLabel)
        contentView.addSubview(topLine)
        contentView.addSubview(underLine)
        contentView.addSubview(titleLabel)
        
        
        //改一些颜色
        sortLabel.textColor = UIColor.blackColor()
        underLine.backgroundColor = UIColor.blackColor()
        topLine.backgroundColor = UIColor.blackColor()
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.font = UIFont.systemFontOfSize(12)
        
        
        smallIconView.snp_makeConstraints { (make) in
            
            make.top.equalTo(self.contentView).offset(5)
            make.left.equalTo(self.contentView).offset(5)
            make.bottom.equalTo(self.contentView).offset(-5)
            //方形!!!
            make.width.equalTo(ScreenWidth - 97 - 40 - 50)
        }
        
        coverView.snp_makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        // logo的x应该是除去缩略图之后, 剩下的一半的位置
        
        let loginView_offSet_X = (ScreenWidth - 170 - 97)/2
        
        let loginView_offSet_Y = (170 - 97 - 40 ) / 2
        
        logoView.snp_makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 97, height: 58))
            make.centerY.equalTo(self.contentView).offset(-loginView_offSet_Y)
            make.left.equalTo(smallIconView.snp_right).offset(45)
        }
        
        sortLabel.snp_makeConstraints { (make) in
            make.center.equalTo(logoView)
        }
        
        topLine.snp_makeConstraints { (make) in
            make.top.equalTo(logoView.snp_bottom).offset(10)
            make.left.equalTo(logoView)
            make.height.equalTo(1)
            make.width.equalTo(logoView.snp_width)
        }
        
        titleLabel.snp_makeConstraints { (make) in
            make.top.equalTo(topLine.snp_bottom).offset(5)
            make.left.width.equalTo(topLine)
        }
        
        underLine.snp_makeConstraints { (make) in
            make.left.equalTo(topLine)
            make.size.equalTo(topLine)
            make.top.equalTo(titleLabel.snp_bottom).offset(5)
        }
        
        
    }
    
    
}