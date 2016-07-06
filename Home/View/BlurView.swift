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
 
    
    override init(effect: UIVisualEffect?) {
        super.init(effect: effect)
        
        setUpUI()
        
        //高斯模糊看着有点难受
        let f = CGFloat(170)
        backgroundColor = UIColor(r: f, g: f, b: f, alpha: 0.7)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK: - SetUpUI
    private func setUpUI(){
    
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
        return self.categories?.count ?? 0
	}
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(CategoryCellReuseIdentifier)!
        
        cell.textLabel?.text = categories![indexPath.row].name
        
        cell.selectionStyle = .None
        
        cell.textLabel?.textAlignment = .Center
        
        cell.textLabel?.font = UIFont(name: "CODE LIGHT", size: 14)
        
       // cell.backgroundColor = UIColor.randomColor(0.1)
        
        cell.backgroundColor = UIColor.clearColor()
        
        return cell
    }
}




