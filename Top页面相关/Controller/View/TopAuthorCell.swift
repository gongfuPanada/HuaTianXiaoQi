//
//  TopAuthorCell.swift
//  HuaTianXiaoQi
//
//  Created by lc－mac on 16/7/6.
//  Copyright © 2016年 lc－mac. All rights reserved.
//

import UIKit



///作者的Cell
class TopAuthorCell: UITableViewCell {

    ///重用ID
    static let cellReuseIDentifier = "cellReuseIDentifier"
    
    ///数据源
    var author: Author?{
    
        didSet{
         
            if let person = author{
            
                let imgUrl = NSURL(string: person.headImg!)
                headImgView.kf_setImageWithURL(imgUrl!, placeholderImage: PlaceholderImage)
                
                authorLabel.text = person.userName ?? "佚名"
                authView.image = person.authImage
                
            }
            
        }
    }
    
    ///名次
    var sort: Int = 1 {
    
        didSet{
        
            sortLabel.text = "\(sort)"
        }
    }
    
    // MARK: - 懒加载
    /// 作者
    private lazy var authorLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "CODE LIGHT", size: 14.0)
        label.text = "花田小憩";
        return label
    }()
    
    /// 头像  圆角处理
    private lazy var headImgView : UIImageView = {
        let headimage = UIImageView()
        headimage.image = UIImage(named: "pc_default_avatar")
        headimage.layer.cornerRadius = 51 * 0.5
        headimage.layer.masksToBounds = true
        headimage.layer.borderWidth = 0.5
        headimage.layer.borderColor = UIColor.lightGrayColor().CGColor
        return headimage
    }()
    
    /// 认证  头像右下角那个小图片V字
    private lazy var authView : UIImageView = {
        let auth = UIImageView()
        auth.image = UIImage(named: "personAuth")
        return auth
    }()
    
    /// 当前第几名
    private lazy var sortLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.blackColor()
        label.font = UIFont.systemFontOfSize(20)
        return label
    }()
    
    //重写init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        setUpUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setUpUI(){
    
        addSubview(headImgView)
        addSubview(authView)
        addSubview(authorLabel)
        addSubview(sortLabel)
        
        //垂直居中 距离左边30 固定尺寸51
        headImgView.snp_makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(30)
            make.size.equalTo(CGSizeMake(51, 51))
        }
        
        authView.snp_makeConstraints { (make) in
            
            make.size.equalTo(CGSizeMake(14, 14))
            make.bottom.right.equalTo(headImgView)
        }
        authorLabel.snp_makeConstraints { (make) in
            make.left.equalTo(headImgView.snp_right).offset(10)
            make.centerY.equalTo(self)
        } 
        sortLabel.snp_makeConstraints { (make) in
            make.right.equalTo(self).offset(-20)
            make.centerY.equalTo(self)
        }
        
    }
    
    
    
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
