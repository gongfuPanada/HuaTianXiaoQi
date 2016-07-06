//
//  TopArticleNormalCell.swift
//  HuaTianXiaoQi
//
//  Created by lc－mac on 16/7/6.
//  Copyright © 2016年 lc－mac. All rights reserved.
//

import Foundation

///专题排名在 1-3 的Cell
class TopArticleNormalCell: TopArticleCell {
    
    //重写父类方法
    override func setUpUI() {
        super.setUpUI()
        
        contentView.addSubview(smallIconView)
        //给缩略图加上蒙版
        smallIconView.addSubview(coverView)
        contentView.addSubview(topLine)
        contentView.addSubview(underLine)
        contentView.addSubview(titleLabel)
        contentView.addSubview(sortLabel)
        contentView.addSubview(logLabel)
        
        
        
        smallIconView.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(5, 5, -5, -5))
        }
        //蒙版无边距
        coverView.snp_makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        //标题处于Cell的正中央
        titleLabel.snp_makeConstraints { (make) in
            make.center.equalTo(contentView)
        }
        //下分割线
        underLine.snp_makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp_bottom).offset(15)
            make.centerX.equalTo(contentView)
            make.height.equalTo(1)
            make.width.equalTo(contentView.snp_height)
        }
        //上分割线
        topLine.snp_makeConstraints { (make) in
            make.bottom.equalTo(titleLabel.snp_top).offset(-15)
            make.centerX.equalTo(contentView)
            make.size.equalTo(underLine.snp_size)
        }
        //排名 
        sortLabel.snp_makeConstraints { (make) in
            make.bottom.equalTo(topLine.snp_top).offset(-5)
            make.centerX.equalTo(contentView)
        }
        //Logo
        logLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(contentView)
            make.top.equalTo(underLine.snp_bottom).offset(5)
        }
        
        
        
        
    }
    
    
}