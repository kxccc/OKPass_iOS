//
//  GeneratePasswordView.swift
//  OKPass
//
//  Created by 陈治成 on 2022/7/12.
//

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
        lenLabel.textAlignment = .right
        lenLabel.text = "\(len)" + "位密码"
        lenSlider.value = 0.5
        lenSlider.addTarget(self, action: #selector(lenSliderValueChanged(_:)), for: .valueChanged)

        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.spacing = 15
        vStack.alignment = .center

        vStack.addArrangedSubview(passwordTextField)
        vStack.addArrangedSubview(lenLabel)
        vStack.addArrangedSubview(lenSlider)
        addSubview(vStack)

        NSLayoutConstraint.activate([
            vStack.leftAnchor.constraint(equalTo: leftAnchor, constant: 40),
            vStack.rightAnchor.constraint(equalTo: rightAnchor, constant: -40),
            vStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            vStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: vStack.widthAnchor),
            lenLabel.widthAnchor.constraint(equalToConstant: 75),
            lenSlider.widthAnchor.constraint(equalTo: vStack.widthAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    @objc func lenSliderValueChanged(_ sender: UISlider) {
        delegate?.lenSliderValueChanged(sender)
    }
}
