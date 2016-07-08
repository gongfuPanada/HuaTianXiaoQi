//
//  HomeTableViewController.swift
//  HuaTianXiaoQi
//
//  Created by lc－mac on 16/6/29.
//  Copyright © 2016年 lc－mac. All rights reserved.
//

import UIKit
import Alamofire

///主页Cell的重用ID
private let HomeArticleReuseIdentifier = "HomeArticleReuseIdentifier"
///主页的TableView
class HomeTableViewController: UITableViewController,BlurViewDelegate{

	// MARK: - 参数/变量
	/// 文章数组
	var articles: [Article]?
	/// 当前页
	var currentPage: Int = 0
	/// 所有的主题分类
	var categories: [Category]?
	/// 选中的分类
	var selectedCategry: Category?
    /// 是否加载更多
    private var toLoadMore = false
    /// 左导航
	private lazy var menuBtn: UIButton = {
		let btn = UIButton()
		btn.setImage(UIImage(named: "menu"), forState: .Normal)
		btn.frame.size = CGSizeMake(20, 20)
		btn.addTarget(self, action: #selector(selectedCategory(_:)), forControlEvents: .TouchUpInside)
		return btn
	}()
    ///导航栏顶部中间的按钮
    private lazy var titleBtn: TitleButton = TitleButton()
    
    ///带有高斯蒙版的TableView视图
    private lazy var blurView: BlurView = {
        let blur = BlurView(effect: UIBlurEffect(style: .Light))
        blur.categories = self.categories
        blur.delegate = self
        return blur
    }()

    // MARK: -BlurViewDelegate
    func blurView(blurView: BlurView, didSelectCategory category: AnyObject) {
        // 去掉高斯蒙版
        selectedCategory(menuBtn)
        // 设置选中的类型
        selectedCategry = category as? Category
        // 开始动画
        refreshControl!.beginRefreshing()
        // 请求数据
        getList()
    }

    
    
    //MARK:  左侧导航按钮的事件
    ///todo  为什么要用ocde 的方法呢 还有为什么要对button的点击状态取反呢???
    
    /*******  START *********/
    // OC中的方法都是运行时加载, 是属于动态的, 用的时候才加载
    // SWift中的方法都是编译时加载, 属于静态的.
    // 如果使用addTarget, 且是private修饰的, 就需要告诉编辑器, 我这个方法是objc的, 属于动态加载
    
    @objc private func selectedCategory(btn: UIButton) {
       
        btn.selected = !btn.selected
        // 如果是需要显示菜单, 先设置transform, 然后再动画取消, 就有一上一下的动画
        if btn.selected {
            
            //添加高斯视图
            tableView.addSubview(blurView)
            //添加约束
            blurView.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(tableView)
                // 这儿的约束必须是设置tableView.contentOffset.y, 而不是设置为和tableView的top相等或者0
                // 因为添加到tableview上面的控件, 一滚动就没了...
                // 为什么+64呢? 因为默认的tableView.contentOffset是(0, -64)
                make.top.equalTo(tableView.contentOffset.y + 64)
                make.size.equalTo(CGSize(width: ScreenWidth, height: ScreenHeight - 49 - 64))
            })
            // 设置transform
            blurView.transform = CGAffineTransformMakeTranslation(0, -ScreenHeight)
        }
        
        //按钮图片的动画
        
        UIView.animateWithDuration(0.5, animations: { 
            
            //动画
            if btn.selected{
                
                 //旋转
                btn.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
                self.blurView.transform = CGAffineTransformIdentity
                self.tableView.bringSubviewToFront(self.blurView)
                self.tableView.scrollEnabled = false
                
            }else{
                
                btn.transform = CGAffineTransformIdentity
                self.blurView.transform = CGAffineTransformMakeTranslation(0, -ScreenHeight)
                self.tableView.scrollEnabled = true
            }

            
            }) { (_) in
                
                //旋转后处理
                if !btn.selected { // 如果是向上走, 回去, 需要removeFromSuperview
                    self.blurView.removeFromSuperview()
                }
                
        }
        
    }
 
    
	override func viewDidLoad() {
		super.viewDidLoad()
 
          setup()
        
        
	}

	//MARK: 设置界面
	private func setup()
	{
		// 设置左右Item
		navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuBtn)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "TOP", style: .Plain, target: self, action: #selector(toTopAction))
        
        
        
        
        //设置title
        navigationItem.titleView = titleBtn
        
        refreshControl = RefreshControl(frame: CGRectZero)
        
        refreshControl?.addTarget(self, action: #selector(getList), forControlEvents: .ValueChanged)
        
        refreshControl?.beginRefreshing()
        
        //设置TableView 相关
        tableView.registerClass(HomeArticleCell.self, forCellReuseIdentifier: HomeArticleReuseIdentifier)
        tableView.rowHeight = CGFloat(330)
        //去掉多余的Cell分割线和 分割线
        tableView.separatorStyle = .None
        tableView.tableFooterView = UIView()
        
        getList()
        
        getCategories()

	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	 

	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
        
		return articles?.count ?? 0
	}

	 
	 override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
	 let cell = tableView.dequeueReusableCellWithIdentifier(HomeArticleReuseIdentifier, forIndexPath: indexPath) as! HomeArticleCell
        //选中效果设置
        cell.selectionStyle = .None
        
        //赋值数据源 这里数据源有didSet方法 所以如果一赋值的话会自动刷新Cell
        let count = articles?.count ?? 0
        
        if count > 0{
        
            let arctile = articles![indexPath.row]
            cell.article = arctile
            //头像点击事件 在定义Cell的时候将这个事件定义了一个闭包 在这块执行这个闭包
            cell.clickHeadImage = { arctile in
                
                print("头像点击事件\(arctile?.author?.userName)")
                
                 }
        }
        
        
        /*
           为了增强用户体验, 我们可以学习新浪微博的做法, 当用户滚动到最后一个Cell的时候,自动加载下一页数据 ,
         每次要用户手动的去加载更多, 就仿佛在告诉用户, 你在我这个APP已经玩了很久了, 该休息了...源源不断的刷新, 就会让用户一直停留在APP上
         
         之前我是使用 MJ_refresh 的上拉刷新来加载数据的,用户必须在最后一个格子显示到底部的时候有一个上拉的动作才会触发继续加载数据的事件
         上面所说的这种方式可以避免这个上拉的操作,在最后一个格子可见的时候就加载数据了应该会快一点不需要等待  学习了!!
         
         */
        
        //如果数据源不为空,并且数据当前Cell已被创建到最后一个,并且允许加载更多
        if count > 0 && indexPath.row == count - 1 && !toLoadMore{
        
            toLoadMore = true
            //当前页加1
            currentPage += 1
            //获取数据
            getList()
        
        }
        
        
        

        return cell
	 }
	 

    //MARK:  获取主页的列表 请求数据
	func getList()
	{
		// 如果正在刷新
		if refreshControl!.refreshing
		{
            reSet()
		}
        // 参数设置
        var paramters = [String : AnyObject]()
        paramters["currentPageIndex"] = "\(currentPage)"
        paramters["pageSize"] = "5"
        // 如果选择了分类就设置分类的请求ID
        if let categry = selectedCategry {
            paramters["cateId"] = categry.id
        }
        
        
        NetworkTool.sharedTools.getHomeList(paramters) { (artices, error, loadAll) in
            
            //停止加载数据
            if self.refreshControl!.refreshing{
             self.refreshControl?.endRefreshing()
            }
            //已经加载到最后一页
            if loadAll{
            
                self.showHint("已经到最后了~\\(≧▽≦)/~", duration: 2, yOffset: 0)
                self.currentPage -= 1
                return
            }
           // 没有出错请求成功
			if error == nil
			{
				// 当前的数据源不为空 就是说明之前有加载过
				if (self.articles) != nil {
                    
					self.toLoadMore = false
					// 数组直接可以这样加 字符数组也可以 必须解包
					self.articles! += artices!

				} else {
					// 当前数据源为空,初次加载 直接赋值
					self.articles = artices!
				}
              //刷新数据
              self.tableView.reloadData()
                
                print("文章加载完成")

			} else {
                
                //获取数据失败后
                
                /*
                 1.将当前页重置到为刷新之前
                 2.将允许加载更多重置
                 3.显示hud提示文字
                 */
                self.currentPage -= 1
                
                if self.toLoadMore {
                    self.toLoadMore = false
                }
                
                self.showHint("网络异常", duration: 2, yOffset: 0)
			}
            
        }
    }
         

    ///获取类别
    
    //todo 为什么在获取类别的时候要先从本地去一下 然后在进行网络获取 这是为什么?
    private func  getCategories(){
    
        //获取本地保存的
        if let array = Category.loadLocalCategories(){
        
            self.categories = array
        }
        
        // 读取网络的Category
        
        NetworkTool.sharedTools.getCategories { (categoies, error) in
            
            if error == nil{
            
                self.categories = categoies
                
                
                print("类别加载完成")
                
                //保存在本地
                Category.saveCategories(categoies!)
                
                
            }else{
            
                ALinLog(error?.domain)
            }
            
        }
        
    }

	/// 重置数据
	func reSet()
	{
        // 重置当前页
		currentPage = 0
		// 重置数组
		articles?.removeAll()
		articles = [Article]()

	}
    
    //MARK: 跳转到Top页面
    func toTopAction(){
    
        self.navigationController?.pushViewController(TopViewController(), animated: true)
    }
    //原来的写法 为啥要用 oc的方法呢??? todo
//    @objc private func toTopAction()
//    {
//        navigationController?.pushViewController(TopViewController(), animated: true)
//    }


}
