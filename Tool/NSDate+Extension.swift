//
//  NSDate+Extension.swift
//  HuaTianXiaoQi
//
//  Created by lc－mac on 16/6/29.
//  Copyright © 2016年 lc－mac. All rights reserved.
//

import Foundation

import UIKit

extension NSDate
{
     ///将String类型的时间格式化成NSDate
    class func dateWithString(dateStr:String)->NSDate?
    {
       let formatter = NSDateFormatter()
        //本地化中国
        formatter.locale = NSLocale(localeIdentifier: "ch")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //一定要设置本地化  要不然系统会解析成其他语言
        return formatter.dateFromString(dateStr)
    }
    
    ///将 date  转换成描述的文字 比如 刚刚 几分钟前 几小时前 等!
    var dateDesc: String {
        let formatter = NSDateFormatter()
        var formatterStr: String?
        formatter.locale = NSLocale(localeIdentifier: "ch")
        //返回当前用户的逻辑日历
        let calenadr = NSCalendar.currentCalendar()
        //是否在今天
        if calenadr.isDateInToday(self)
        {
           //返回两个时间的间隔 秒的形式  这里接收点取当前时间
        let seconds = NSDate().timeIntervalSinceDate(self)

			if seconds < 60 {
				return "刚刚"
			}
			else if seconds < 60 * 60 {
				return "\(seconds/60)分钟前"
			}
			else {
                return "\(seconds/60/60)小时前"
			}

        }
        else if calenadr.isDateInYesterday(self)
        {
          formatterStr = "昨天 HH:mm"
        }
        else{
           //很多年以前的这种情况
            let component = calenadr.components(NSCalendarUnit.Year, fromDate: self, toDate: NSDate(), options: [])
            
            if component.year < 1 {
             
                formatterStr = "MM-dd HH:mm"
                
            }else{
              formatterStr = "yyyy-MM-dd HH:mm"
            }
            
        }
        
        formatter.dateFormat = formatterStr
        
        return formatter.stringFromDate(self)
    }
    
}