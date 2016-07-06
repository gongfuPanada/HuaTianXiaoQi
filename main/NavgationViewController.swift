//
//  NavgationViewController.swift
//  HuaTianXiaoQi
//
//  Created by lc－mac on 16/6/29.
//  Copyright © 2016年 lc－mac. All rights reserved.
//

import UIKit

///自己重写的导航控制器
class NavgationViewController: UINavigationController {
     
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        
        if childViewControllers.count > 0
        {
           viewController.hidesBottomBarWhenPushed = true
            
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: .Done, target: self, action: #selector(self.back))
        }
        
        ///由于粗心大意忘记写了这句代码 结果程序一直不对
        //记住以后重写系统类的时候一定要调用基本的构造方法 我擦擦擦!!!
         super.pushViewController(viewController, animated: true)
    }

    //重写Back方法
    func back()
    {
       popViewControllerAnimated(true)
    }
    
}
