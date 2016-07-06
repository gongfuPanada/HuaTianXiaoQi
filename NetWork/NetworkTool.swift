//
//  NetworkTool.swift
//  HuaTianXiaoQi
//
//  Created by lc－mac on 16/7/4.
//  Copyright © 2016年 lc－mac. All rights reserved.
//

import Foundation
import Alamofire


///同于网络请求
class NetworkTool:Alamofire.Manager{

    ///单例
    internal static let sharedTools:NetworkTool = {
    
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        var header : Dictionary =  Manager.defaultHTTPHeaders
        configuration.HTTPAdditionalHeaders = Manager.defaultHTTPHeaders
        
        return NetworkTool(configuration: configuration)
        
    }()
    
    
    //MARK: 获取主页的列表 
    //参数(请求参数,成功返回的闭包(文章数据模型,错误,Bool))
    func  getHomeList(paramats:[String:AnyObject]?,finished:(artices:[Article]?,error:NSError?,loadAll:Bool)->Void){
    
        request(.POST, "http://m.htxq.net/servlet/SysArticleServlet?action=mainList", parameters: paramats, encoding: .URL, headers: nil)
        
        .responseJSON(queue: dispatch_get_main_queue(),options: .MutableContainers) { (response) in
            //打印信息
            //ALinLog(response.result.value)
            //如果请求成功
            if response.result.isSuccess{
                if let value = response.result.value{
                    if (value["msg"] as! NSString).isEqualToString("已经到最后"){
                        //执行闭包
                        finished(artices: nil, error: response.result.error, loadAll: true)
                    }else if let result = value["result"]{
                        
                        var arcicles = [Article]()
                        //将得到的结果转换为  字典的数组
                        for dic in result as![[String:AnyObject]]{
                          
                            arcicles.append(Article(dict:dic))
                        }
                        // 请求和构造数据完成
                        finished(artices: arcicles, error: nil, loadAll: false)
                    }

                }
               
            } //请求没有成功  返回数据为nil
            else{
                finished(artices: nil, error: response.result.error, loadAll: false)
            }
            
        }
    
    }
    
    //变Y为I 加es
    ///请求类别
	func getCategories(finished: (categoies: [Category]?, error: NSError?) -> Void) {

		request(.GET, "http://m.htxq.net/servlet/SysCategoryServlet?action=getList", parameters: nil, encoding: .URL, headers: nil)

			.responseJSON(queue: dispatch_get_main_queue(), options: .MutableContainers) { (response) in
                // 请求成功
				if response.result.isSuccess {
					// 请求有数据
					if let dictValue = response.result.value {
						// 有要找的节点
						if let resultValue = dictValue["result"] {
							// 生成对应的模型数组
							var categories = [Category]()
							for dict in resultValue as! [[String: AnyObject]] {

								categories.append(Category(dict: dict))
							}
							// 完成 执行闭包
							finished(categoies: categories, error: nil)
						}
						// 没有找到要的节点
						else {
							// 执行闭包
							finished(categoies: nil, error: NSError(domain: "服务器异常", code: 44, userInfo: nil))
						}
						// 请求没有数据
					} else {
						finished(categoies: nil, error: NSError.init(domain: "请求没有数据", code: 44, userInfo: nil))
					}
                }
				// 请求失败
				else {
					finished(categoies: nil, error: response.result.error)
				}
        }
	}
    
    
    
    ///请求Top数据
    func getTop10(action:TOP10Action,finished:(objs:[AnyObject]?,error:NSError?)->Void){
         //url中有中文 要用 URLEncodedInURL
        request(.GET, "http://ec.htxq.net/servlet/SysArticleServlet?currentPageIndex=0&pageSize=10", parameters: ["action" : action.rawValue], encoding: .URLEncodedInURL, headers: nil)
        .responseJSON { (response) in
            
            if let value = response.result.value{
            
                //如果请求的是作者
                if action == TOP10Action.TopArticleAuthor{
                 
                    var authors = [Author]()
                    
                    for dic in value["result"] as! [[String:AnyObject]]{
                    
                        authors.append(Author(dict: dic))
                        print(dic["userName"]!)
                    }
                    finished(objs: authors, error: nil)
                    
                }
                //是专栏
                else{
                
                    var article = [Article]()
                    
                    for dic in value["result"] as! [[String:AnyObject]]{
                    
                        article.append(Article(dict: dic))
                    }
                    
                    finished(objs: article, error: nil)
                }
                
                
            }
            else{
                finished(objs: nil, error: response.result.error)
            }
        }
    }
}





