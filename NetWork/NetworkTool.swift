//
//  NetworkTool.swift
//  HuaTianXiaoQi
//
//  Created by lc－mac on 16/7/4.
//  Copyright © 2016年 lc－mac. All rights reserved.
//

import Foundation
import Alamofire




class NetworkTool:Alamofire.Manager{

    ///单例
    internal static let sharedTools:NetworkTool = {
    
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        var header : Dictionary =  Manager.defaultHTTPHeaders
        configuration.HTTPAdditionalHeaders = Manager.defaultHTTPHeaders
        
        return NetworkTool(configuration: configuration)
        
    }()
    
    
    /// 获取主页的列表 参数(请求参数,成功返回的闭包(文章数据模型,错误,Bool))
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
                //请求没有成功  返回数据为nil
                else{
                 finished(artices: nil, error: response.result.error, loadAll: false)
                }
            }
                       
        }
    
        
    }
}





