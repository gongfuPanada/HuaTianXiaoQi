//
//  TopViewController.swift
//  HuaTianXiaoQi
//
//  Created by lc－mac on 16/7/6.
//  Copyright © 2016年 lc－mac. All rights reserved.
//

import UIKit

class TopViewController: UIViewController {

    private lazy var tableView : UITableView = {
    
        var table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView()
        //todo
        //注册作者的Cell
        table.registerClass(TopAuthorCell.self, forCellReuseIdentifier: TopAuthorCell.cellReuseIDentifier)
        //注册专栏的Cell
        //1-3
        table.registerClass(TopArticleNormalCell.self, forCellReuseIdentifier: TOP10ArticleCellID.TopActicleNormalCellReusedIdtentfier.rawValue)
        //其他 todo
        table.registerClass(TopArticleOtherCell.self, forCellReuseIdentifier: TOP10ArticleCellID.TopActicleOtherCellReusedIdtentfier.rawValue)
        
        table.separatorStyle = .None
        
        return table
    }()
    ///数据源
    var dataSourse:[AnyObject]?{
    
        didSet{
        
            tableView.reloadData()
        }
    }
    
    ///用于保存当前的要加载那个数据 作者 专栏,这个数据会在点击button的时候更新 默认专栏
    var action: TOP10Action = TOP10Action.TopContents
    
    
    // MARK : 懒加载
    /// 顶部的菜单
    private lazy var topMenuView : TopMenuView = TopMenuView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        getList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setUpUI(){
     
        view.backgroundColor = UIColor.whiteColor()
        
        navigationItem.title = "本周Top10"
        
        view.addSubview(topMenuView)
        view.addSubview(tableView)
         
        topMenuView.snp_makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.view).offset(64)
            make.height.equalTo(40)
        }
        tableView.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(topMenuView.snp_bottom)
        }
        
        topMenuView.delegate = self
    }

    //请求数据
   func getList() {
    
     // 这块有一个不好的地方就是每一次点击一次按钮数据都是从服务器重新加载的 todo
     NetworkTool.sharedTools.getTop10(self.action) { (objs, error) in
			if error == nil {

				self.dataSourse = objs
			}
			else {

				self.showHint(error.debugDescription, duration: nil, yOffset: nil)
			}
		}

	}
    
    
}
//MARK: TableView的代理实现
extension TopViewController:UITableViewDelegate,UITableViewDataSource{

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
       
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return dataSourse?.count ?? 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if self.action == TOP10Action.TopArticleAuthor{
        
            return CGFloat(60)
        }
        return CGFloat(170)
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //先判断当前要加载哪个部分的Cell 根据Action
        //作者
        let count = dataSourse?.count ?? 0
        if action == TOP10Action.TopArticleAuthor{
        
            let cell = tableView.dequeueReusableCellWithIdentifier(TopAuthorCell.cellReuseIDentifier) as! TopAuthorCell
            if count > 0{
            
                cell.author = dataSourse![indexPath.row] as? Author
                //下标从0开始 所以这里要加1
                cell.sort = indexPath.row+1
            }
            
            cell.selectionStyle = .None
            return cell
        }
        
         //属于专题
        
        let category  = indexPath.row >= 3 ? TOP10ArticleCellID.TopActicleOtherCellReusedIdtentfier : TOP10ArticleCellID.TopActicleNormalCellReusedIdtentfier
        
        
        //todo
        //在这块为什么要转换成 父类Cell???
        let cell = tableView.dequeueReusableCellWithIdentifier(category.rawValue) as! TopArticleCell
        
        if count > 0{
        
            cell.article = self.dataSourse![indexPath.row] as? Article
            cell.sort = indexPath.row + 1
            
        }
        
         cell.selectionStyle = .None
         return cell
    }


}
//MARK: TopMenuView的代理
extension TopViewController:TopMenuViewDelegate{
    
    func topMenuView(topMenuView: TopMenuView, selectedTopAction action: TOP10Action.RawValue) {
        
        //传过来的是String 类型这里要进行转换
        self.action = action == TOP10Action.TopArticleAuthor.rawValue ? TOP10Action.TopArticleAuthor : TOP10Action.TopContents
        
        getList()
    }
}
