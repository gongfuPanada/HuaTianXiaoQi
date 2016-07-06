//
//  BlurView.swift
//  HuaTianXiaoQi
//
//  Created by lc－mac on 16/7/5.
//  Copyright © 2016年 lc－mac. All rights reserved.
//

import Foundation

///TableViewCell的重用ID
private let CategoryCellReuseIdentifier = "CategoryCellReuseIdentifier"

// MARK: 协议
@objc
protocol BlurViewDelegate:NSObjectProtocol {
    ///定义的协议方法
    optional func blurView(blurView: BlurView,didSelectCategory category:AnyObject)
}

///带有高斯蒙版的TableView视图
class BlurView: UIVisualEffectView,UITableViewDelegate,UITableViewDataSource {
    
     ///持有的代理
    weak var delegate:BlurViewDelegate?
    
    ///TableView
    private lazy var tableView: UITableView = {
    
        let tab = UITableView(frame: CGRectZero, style: .Plain)
        tab.delegate = self
        tab.dataSource = self
        //这里颜色取透明色
        tab.backgroundColor = UIColor.clearColor()
        //去掉table多余的分割线
        tab.tableFooterView = UIView()
        tab.separatorStyle = .None
        tab.rowHeight = 60
        //注册可重用ID
        tab.registerClass(UITableViewCell.self, forCellReuseIdentifier: CategoryCellReuseIdentifier)
        
        return tab
    }()
    
    ///底部Logo
    private lazy var bottomView: UIImageView = UIImageView(image: UIImage(named: "l_regist"))
    
    ///底部的分割线
     private lazy var underLine : UIImageView = UIImageView(image: UIImage(named: "underLine"))
    
    /// 分类数组
    var categories : [AnyObject]?
        {
        didSet{
            if let _ = categories {
                tableView.reloadData()
            }
        }
    }

    
    
    
    //MARK: - SetUpUI
    private func SetUpUI(){
    
        //todo
        
        addSubview(tableView)
        addSubview(bottomView)
        addSubview(underLine)
        
        
        tableView.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(40)
            make.bottom.equalTo(underLine.snp_top)
        }
        
        bottomView.snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self).offset(-10)
            make.height.equalTo(27)
        }
        
        underLine.snp_makeConstraints { (make) in
            make.left.right.equalTo(self).offset(0)
            make.bottom.equalTo(bottomView.snp_top).offset(-10)
        }
    
    
    }
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
         
        return 1
    }
    
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
        return 5
	}
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        cell.textLabel?.text = "第\(indexPath.row)行"
        
        return cell
    }
}




