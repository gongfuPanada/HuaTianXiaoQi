//
//  ColumnistViewController.swift
//  HuaTianXiaoQi
//
//  Created by lc－mac on 16/7/14.
//  Copyright © 2016年 lc－mac. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"


///专栏作家简介页面
class ColumnistViewController: UICollectionViewController {

    ///作者
    var auther: Author?
    ///作者写的所有文章的数据
    var articles: [Article]?{
    
        didSet{
        
            if let _ = articles{
                //这里原作者解包了 !
                collectionView?.reloadData()
            }
        }
    }
    
    init(){
        //重写父类的方法 传入CollectionID
        super.init(collectionViewLayout: CollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
       setUp()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.articles?.count ?? 3
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ArticlesCollectionViewCell
        
        if let art = self.articles{
        
            if art.count>0{
            
                cell.article  = art[indexPath.row]
            }
        }
     
      return cell
    }
    
     

    
    //MARK: - 私有方法
    ///设置界面相关
    private func setUp(){
    
        collectionView?.backgroundColor = UIColor.whiteColor()
        
        navigationItem.title = "个人中心"
        
       // 注册复用单元格
       self.collectionView!.registerClass(ArticlesCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        

        
    }

    private func getList(){
    
        
        
    }
}
