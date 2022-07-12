//
//  GeneratePasswordVC.swift
//  OKPass
//
//  Created by 陈治成 on 2022/7/12.
//

import UIKit

class GeneratePasswordVC: UIViewController {
    private var v: GeneratePasswordView!
    override func viewDidLoad() {
        super.viewDidLoad()
        v = GeneratePasswordView(frame: CGRect(x: 0, y: view.safeAreaInsets.top, width: view.bounds.width, height: view.bounds.height))
        view.backgroundColor = .white
        view.addSubview(v)
    }
}
