//
//  Article.swift
//  HuaTianXiaoQi
//
//  Created by lc－mac on 16/6/29.
//  Copyright © 2016年 lc－mac. All rights reserved.
//

import Foundation


///文章数据模型
class Article: NSObject {
    
 ///创建时间
 var createDate: String?
	{
		didSet {
            
            if var dateStr = createDate  {
               if dateStr.containsString(".0")
               {
                 dateStr = dateStr.stringByReplacingOccurrencesOfString(".0", withString: "")
               }
               
                let time: NSDate? = NSDate.dateWithString(dateStr)
                
                if let t = time
                {
                  createDateDesc = t.dateDesc
                }
            }
		}
	}
    
    
 ///描述创建时间,比如今天,明天等
  var createDateDesc: String?
    
  
    /// 摘要
	var desc: String?
	/// 评论数
	var fnCommentNum: Int = 0
	/// 点赞数addchildviewcontroller并不会执行viewdidload，addchildviewcontroller之后必须调用，viewcontroller的view，才会执行viewdidload
	var favo: Int = 0
	/// 文章ID
	var id: String?
	/// 序号
	var order: Int = 0
	/// 文章的H5地址
	var pageUrl: String?
	/// 阅读数
	var read: Int = 0
	/// 分享数
	var share: Int = 0
	/// 用户分享的URL
	var sharePageUrl: String?
	/// 缩略图
	var smallIcon: String?
	/// 文章标题
	var title: String?
	/// 是否是首页的, 如果是首页不显示时间
	var isNotHomeList: Bool = false
    
    
    ///作者
    var author : Author?
    
    ///所属分类
    var category: Category?
    
    init(dict:[String:AnyObject]) {
        super.init()
        // 构造数据
        setValuesForKeysWithDictionary(dict)
    }
    
    /// 重写setValue方法 来对 作者和所属分类进行重新构造
    override func setValue(value: AnyObject?, forKey key: String) {
        
        // 处理作者
        if key == "author"
        {
            if let valueOfKey = value{
                self.author = Author(dict: valueOfKey as! [String:AnyObject])
            }
            return
        }
        // 处理所属类别
        else if key == "category"{
        
            if let  valyeOfKey = value{
                self.category = Category(dict: valyeOfKey as! [String:AnyObject])
             }
            return
        }
        //默认情况
        super.setValue(value, forKey: key)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
}