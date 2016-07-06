//
//  TopArticleCell.swift
//  HuaTianXiaoQi
//
//  Created by lc－mac on 16/7/6.
//  Copyright © 2016年 lc－mac. All rights reserved.
//

import UIKit

class TopArticleCell: UITableViewCell {

    //数据源
    var article: Article?{
    
        didSet{
        
            if let art = article{
                //一个布尔值，该值决定是否该视图是不透明的。
                smallIconView.opaque = false
                
                let imgUrl = NSURL(string: art.smallIcon!)
                
                smallIconView.kf_setImageWithURL(imgUrl!, placeholderImage: PlaceholderImage, optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                
                titleLabel.text = art.title
            }
        }
    }
    //排名
    var sort :Int = 1{
    
        didSet{
        
            sortLabel.text = "Top "+"\(sort)"
        }
    }
    
    //MARK: 懒加载
    /// 缩略图
    lazy var smallIconView : UIImageView = UIImageView()
    
    /// 蒙版  要覆盖在图片上 好显示文字
    lazy var coverView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blackColor()
        view.alpha = 0.3
        return view
    }()
    
    /// 标题
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(15)
        label.textAlignment = .Center
        label.textColor = UIColor.whiteColor()
        return label
    }()
    /// 上面的白色分割线
    lazy var topLine : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        return view
    }()
    
    /// 下面的白色分割线
    lazy var underLine : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        return view
    }()
    /// 名次
    lazy var sortLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(11)
        label.textColor = UIColor.whiteColor()
        return label
    }()
    /// Logo
    lazy var logLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(10)
        label.textColor = UIColor.whiteColor()
        label.text = "FLORAL & FILE"
        return label
    }()

    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
         setUpUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func setUpUI(){
    
        //有一个内部间距5 看起来有层次感
        backgroundColor = UIColor(gray: 200)
        
        self.contentView.backgroundColor = UIColor.whiteColor()
        
        
        //造成一个照片的效果 四周都有5像素的白色
        let ude = UIEdgeInsetsMake(0, 5, -5, -5)
        
        self.contentView.snp_makeConstraints { (make) in
           
            make.edges.equalTo(ude)
        }
    }
    
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
