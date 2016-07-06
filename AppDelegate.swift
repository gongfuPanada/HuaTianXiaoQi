//
//  AppDelegate.swift
//  HuaTianXiaoQi
//
//  Created by lc－mac on 16/6/28.
//  Copyright © 2016年 lc－mac. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        //配置全局导航
        let bar = UINavigationBar.appearance()
        bar.tintColor = UIColor.blackColor()
        bar.titleTextAttributes = [NSFontAttributeName : UIFont.systemFontOfSize(15), NSForegroundColorAttributeName : UIColor.blackColor()]
        
        //设置windows
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        //是否进入新特性
        
        if needToNewFeature()
        {
           print("进入新版本")
           window?.rootViewController = NewFeatureCollectionViewController()
        }
        else
        {
           
           window?.rootViewController = MainViewController()
        }
        
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

     //MARK: - 私有
    
    private let SLBundleShortVersionString = "SLBundleShortVersionString"
    /// 是否需要进入新特性控制器
    func needToNewFeature()->Bool
    {
        //当前的版本
        let currentVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String
        //保存在本地的版本
        let oldVersion = NSUserDefaults.standardUserDefaults().objectForKey(SLBundleShortVersionString) ?? ""
        
        //如果当前的版本号和本地的版本号比较,是降序,返回 true (显示新特性页面)
        if (currentVersion.compare(oldVersion as! String)) == .OrderedDescending
        {
           //保存当前的版本号
           NSUserDefaults.standardUserDefaults().setObject(currentVersion, forKey: SLBundleShortVersionString)
            
           return true
        }
        
        
        return false
        
    }
    
    
}

// 首先要明确一点: swift里面是没有宏定义的概念
// 自定义内容输入格式: 文件名[行号]函数名: 输入内容
// 需要在info.plist的other swift flag的Debug中添加DEBUG
// 在Budding Setting 中设置
///自定义的输出
func ALinLog<T>(message:T,fileName: String = #file,lineNum:Int = #line,funcName:String=#function)
{
    #if DEBUG
        print("DEBUG:{ 文件:\((fileName as NSString).lastPathComponent), 行号:\(lineNum), 方法名: \(funcName), 信息: \(message) }")
    #endif
}


