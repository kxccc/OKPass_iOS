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

        v = GeneratePasswordView()
        v.delegate = self
        view.addSubview(v)
    }

    override func viewWillLayoutSubviews() {
        v.frame = CGRect(x: view.safeAreaInsets.left,
                         y: view.safeAreaInsets.top,
                         width: view.bounds.width - view.safeAreaInsets.left - view.safeAreaInsets.right,
                         height: view.bounds.height - view.safeAreaInsets.bottom - view.safeAreaInsets.top)
    }
}

extension GeneratePasswordVC: GeneratePasswordViewDelegate {
    func lenSliderValueChanged(_ sender: UISlider) {
        let minLen = 8
        let maxLen = 24
        v.len = Int(sender.value * Float(maxLen - minLen)) + minLen
    }
}
