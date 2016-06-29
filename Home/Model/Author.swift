//
//  Author.swift
//  HuaTianXiaoQi
//
//  Created by lc－mac on 16/6/29.
//  Copyright © 2016年 lc－mac. All rights reserved.
//

import Foundation

/// 作者数据模型
class Author: NSObject {
    
    /// 认证类型  作家...等
    var auth: String?
    /// 所在城市
    var city: String?
    /// 简介
    var connect: String?
    /// 是否订阅
    var dingYue: Int = 0
    /// 头像
    var headImg: String?
        {
        didSet{
            //如果头像url中不含有http://
            if !headImg!.hasPrefix("http://") {
              headImg = "http://static.htxq.net/" + headImg!
              }
        }
    }
    /// 用户ID
	var id: String?
	/// 标示: 官方认证
	var identity: String?
	/// 用户名
	var userName: String?
	//// 手机号
	var mobile: Int64 = 18618234090
	/// 订阅数
	var subscibeNum: Int = 0
	/// 认证的等级, 1是yellow, 2是个人认证
    var newAuth: Int = 0
        {
        didSet{
         
            switch newAuth {
            case 1:
                
            default:
                <#code#>
            }
        }
    }
    
    
    
    
}