//
//  TabBarController.swift
//  OKPass
//
//  Created by 陈治成 on 2022/7/7.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let vc = PasswordVC()
        vc.title = "密码本"
        vc.tabBarItem.image = UIImage(systemName: "key.icloud")
        vc.tabBarItem.selectedImage = UIImage(systemName: "key.icloud.fill")
        let nc = UINavigationController(rootViewController: vc)

        let vc2 = MeVC()
        vc2.title = "我的"
        vc2.tabBarItem.image = UIImage(systemName: "person")
        vc2.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        let nc2 = UINavigationController(rootViewController: vc2)

        viewControllers = [nc, nc2]
    }
}
