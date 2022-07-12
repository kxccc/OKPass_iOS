//
//  GeneratePasswordView.swift
//  OKPass
//
//  Created by 陈治成 on 2022/7/12.
//

import UIKit

@IBDesignable class GeneratePasswordView: UIView {
    private var len = 16 {
        didSet {
            lenLabel.text = "\(len)" + "位密码"
        }
    }

    private let passwordTextField: UITextField = .init()
    private let lenLabel: UILabel = .init()
    private let lenSlider: UISlider = .init()
    private let upLetterLabel: UILabel = .init()
    private let downLetterLabel: UILabel = .init()
    private let digitalLabel: UILabel = .init()
    private let upLetterSwitch: UISwitch = .init()
    private let downLetterSwitch: UISwitch = .init()
    private let digitalSwitch: UISwitch = .init()
    private let generateButton: UIButton = .init()
    private let confirmButton: UIButton = .init()

    override init(frame: CGRect) {
        super.init(frame: frame)

        passwordTextField.borderStyle = .roundedRect
        len = 16
        lenLabel.text = "\(len)" + "位密码"
        len = 15

        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.spacing = 15

        vStack.addArrangedSubview(passwordTextField)
        vStack.addArrangedSubview(lenLabel)
        vStack.addArrangedSubview(lenSlider)
        addSubview(vStack)

        NSLayoutConstraint.activate([
            vStack.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            vStack.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),
            vStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            vStack.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
