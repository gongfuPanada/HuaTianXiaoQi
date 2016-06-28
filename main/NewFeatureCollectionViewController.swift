//
//  NewFeatureCollectionViewController.swift
//  HuaTianXiaoQi
//
//  Created by lc－mac on 16/6/28.
//  Copyright © 2016年 lc－mac. All rights reserved.
//

import UIKit

import SnapKit

private let reuseIdentifier = "Cell"

class NewFeatureCollectionViewController: UICollectionViewController {

    //无参数的构造函数 来设定布局方式
    init() {
        super.init(collectionViewLayout: NewFeatureLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //要展示的图片数组
    private let imageNames :[String] = ["gp_bg_0","gp_bg_1", "gp_bg_2"]
    //pageControl
    private lazy var pageControl:UIPageControl = {
        let pageControll = UIPageControl()
        pageControll.numberOfPages = self.imageNames.count ?? 0
        pageControll.pageIndicatorTintColor = UIColor.whiteColor()
        pageControll.currentPageIndicatorTintColor = UIColor.redColor()
        return pageControll
    }()
  
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    
    //MARK:- 设置界面
    func setup()
    {
        // 注册可重用单元格
        self.collectionView!.registerClass(NewFeatureCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        self.collectionView?.addSubview(pageControl)
        
        //约束
        pageControl.snp_makeConstraints { (make) in
            make.bottom.equalTo(self.view).offset(-10)
            make.centerX.equalTo(self.view)
            make.size.equalTo(CGSize(width: 100,height: 20))
        }
        
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return imageNames.count ?? 0
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 1
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! NewFeatureCell
    
        // Configure the cell
        
        let count = imageNames.count ?? 0
        
        if count > 0
        {
          cell.image = UIImage(named: imageNames[indexPath.row])
        }
        
        
        return cell
    }
    
    //Cell的点击事件
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        
    }
 

}


//MARK:-自定义 布局类 用于构造函数 (流布局)
class NewFeatureLayout:UICollectionViewFlowLayout
{
    override func prepareLayout() {
        
        //格子的大小等于屏幕的大小
        self.itemSize  = UIScreen.mainScreen().bounds.size
        //设置间距
        self.minimumLineSpacing = 0
        self.minimumInteritemSpacing = 0
        //设置方向
        self.scrollDirection = .Horizontal
        //分页
        self.collectionView?.pagingEnabled = true
        //横向和竖向的滚动条都不显示
        self.collectionView?.showsHorizontalScrollIndicator = false
        self.collectionView?.showsVerticalScrollIndicator = false
        //弹簧效果关闭
        self.collectionView?.bounces = false
    }

}


//MARK:- 定制Cell
class NewFeatureCell:UICollectionViewCell
{
    //图片控件
    private lazy var imageView:UIImageView = UIImageView()
    
    //显示的图片
    var  image: UIImage?
    {
        didSet{
          
            if let img = image
            {
               imageView.image = img
            }
        }
    }
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
         
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup()
    {
       self.contentView.addSubview(imageView)
        
       imageView.snp_makeConstraints { (make) in
        
        make.edges.equalTo(0)
      }
    }


}

