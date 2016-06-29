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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        
        if childViewControllers.count > 0
        {
           viewController.hidesBottomBarWhenPushed = true
            
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: .Done, target: self, action: #selector(self.back))
        }
    }

    //重写Back方法
    func back()
    {
       popViewControllerAnimated(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
