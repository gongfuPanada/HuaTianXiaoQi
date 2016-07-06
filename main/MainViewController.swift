//
//  MainViewController.swift
//  HuaTianXiaoQi
//
//  Created by lc－mac on 16/6/28.
//  Copyright © 2016年 lc－mac. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController,UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    func setup()
    {
        tabBar.tintColor = UIColor.blackColor()
       //添加home
      // NSLocalizedString  简单的本地化 返回本地字符串 如果没有指定 返回主包
       addViewController(HomeTableViewController(), title: NSLocalizedString("tab_theme", comment: ""))
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    ///为主页添加子控件
    private func addViewController(childController:UIViewController,title:String)
    {
        //构造成自己定制的类 因为重写了返回的按钮
       let nav = NavgationViewController(rootViewController: childController)
      
        addChildViewController(nav)
        
       childController.tabBarItem.title = title
       childController.tabBarItem.image = UIImage(named: "tb_\(childViewControllers.count - 1)")
       
       childController.tabBarItem.selectedImage = UIImage(named: "tb_\(childViewControllers.count - 1)" + "_selected")
        
        //方便点击判断 设置 Tag
       childController.tabBarItem.tag = childViewControllers.count - 1
        
    }
   
}
