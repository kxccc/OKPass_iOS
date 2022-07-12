//
//  GeneratePasswordView.swift
//  OKPass
//
//  Created by 陈治成 on 2022/7/12.
//

import SwiftUI
import UIKit

protocol GeneratePasswordViewDelegate: AnyObject {
    func lenSliderValueChanged(_ sender: UISlider)
}

@IBDesignable class GeneratePasswordView: UIView {
    var len: Int = 16 {
        didSet {
            lenLabel.text = "\(len)" + "位密码"
        }
    }

    weak var delegate: GeneratePasswordViewDelegate?
    private let passwordTextField: UITextField = .init()
    private let lenLabel: UILabel = .init()
    private let lenSlider: UISlider = .init()
    private let uppercaseLabel: UILabel = .init()
    private let lowercaseLabel: UILabel = .init()
    private let numbersLabel: UILabel = .init()
    private let symbolsLabel: UILabel = .init()
    let uppercaseSwitch: UISwitch = .init()
    let lowercaseSwitch: UISwitch = .init()
    let numbersSwitch: UISwitch = .init()
    let symbolsSwitch: UISwitch = .init()
    private let generateButton: UIButton = .init()
    private let confirmButton: UIButton = .init()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.systemBackground

        passwordTextField.borderStyle = .roundedRect
        lenLabel.textAlignment = .right
        lenLabel.text = "\(len)" + "位密码"
        lenSlider.value = 0.5
        lenSlider.addTarget(self, action: #selector(lenSliderValueChanged(_:)), for: .valueChanged)

        let uppercaseStack = UIStackView()
        uppercaseLabel.text = "包含大写字母"
        uppercaseStack.addArrangedSubview(uppercaseLabel)
        uppercaseStack.addArrangedSubview(uppercaseSwitch)

        let lowercaseStack = UIStackView()
        lowercaseLabel.text = "包含小写字母"
        lowercaseStack.addArrangedSubview(lowercaseLabel)
        lowercaseStack.addArrangedSubview(lowercaseSwitch)

        let numbersStack = UIStackView()
        numbersLabel.text = "包含数字"
        numbersStack.addArrangedSubview(numbersLabel)
        numbersStack.addArrangedSubview(numbersSwitch)

        let symbolsStack = UIStackView()
        symbolsLabel.text = "包含特殊字符"
        symbolsStack.addArrangedSubview(symbolsLabel)
        symbolsStack.addArrangedSubview(symbolsSwitch)

        let buttonStack = UIStackView()
        buttonStack.spacing = 20
        generateButton.configuration = .gray()
        generateButton.setTitle("重新生成", for: .normal)
        confirmButton.configuration = .filled()
        confirmButton.setTitle("使用", for: .normal)
        buttonStack.addArrangedSubview(generateButton)
        buttonStack.addArrangedSubview(confirmButton)

        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.spacing = 15
        vStack.alignment = .center

        vStack.addArrangedSubview(passwordTextField)
        vStack.addArrangedSubview(lenLabel)
        vStack.addArrangedSubview(lenSlider)
        vStack.addArrangedSubview(uppercaseStack)
        vStack.addArrangedSubview(lowercaseStack)
        vStack.addArrangedSubview(numbersStack)
        vStack.addArrangedSubview(symbolsStack)
        vStack.addArrangedSubview(buttonStack)
        addSubview(vStack)

        NSLayoutConstraint.activate([
            vStack.leftAnchor.constraint(equalTo: leftAnchor, constant: 40),
            vStack.rightAnchor.constraint(equalTo: rightAnchor, constant: -40),
            vStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            vStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: vStack.widthAnchor),
            lenLabel.widthAnchor.constraint(equalToConstant: 75),
            lenSlider.widthAnchor.constraint(equalTo: vStack.widthAnchor),
            uppercaseStack.widthAnchor.constraint(equalToConstant: 170),
            lowercaseStack.widthAnchor.constraint(equalToConstant: 170),
            numbersStack.widthAnchor.constraint(equalToConstant: 170),
            symbolsStack.widthAnchor.constraint(equalToConstant: 170),
        ])
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    @objc func lenSliderValueChanged(_ sender: UISlider) {
        delegate?.lenSliderValueChanged(sender)
    }
}
