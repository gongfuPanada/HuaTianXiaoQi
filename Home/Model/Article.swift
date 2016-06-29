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
	/// 点赞数
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
    
}