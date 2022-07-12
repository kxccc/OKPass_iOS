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

        view.backgroundColor = .white
        v = GeneratePasswordView()
        v.delegate = self

        let stack = UIStackView()
        stack.addArrangedSubview(v)
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.leftAnchor.constraint(equalTo: view.leftAnchor),
            stack.rightAnchor.constraint(equalTo: view.rightAnchor),
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension GeneratePasswordVC: GeneratePasswordViewDelegate {
    func lenSliderValueChanged(_ sender: UISlider) {
        let minLen = 8
        let maxLen = 24
        v.len = Int(sender.value * Float(maxLen - minLen)) + minLen
    }
}
