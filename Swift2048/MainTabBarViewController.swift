//
//  MainTabBarViewController.swift
//  Swift2048
//
//  Created by Sunhy on 16/12/21.
//  Copyright © 2016年 Sunhy. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    init() {
        super.init(nibName: nil, bundle: nil)
        let mainVC = MainViewController()
        mainVC.title = "游戏"
        mainVC.tabBarItem.image = UIImage(named: "game")
        let settingVC = SettingViewController(mainView: mainVC)
        settingVC.title = "设置"
        settingVC.tabBarItem.image = UIImage(named:"setting")
        let main = UINavigationController(rootViewController: mainVC)
        let setting = UINavigationController(rootViewController: settingVC)
        self.viewControllers = [main, setting]
        self.tabBar.tintColor = UIColor.orange
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
