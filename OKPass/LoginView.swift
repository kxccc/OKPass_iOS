//
//  LoginView.swift
//  OKPass
//
//  Created by 陈治成 on 2022/7/13.
//

import UIKit

protocol LoginViewDelegate: AnyObject {
    func clickJumpButton(_ senderView: LoginView)
    func clickAccountButton(_ senderView: LoginView)
    func clickGetCaptchaButton(_ senderView: LoginView)
}

class LoginView: UIView {
    weak var delegate: LoginViewDelegate?
    var emailTextField: UITextField = .init()
    var passwordTextField: UITextField = .init()
    var captchaTextField: UITextField = .init()
    var getCaptchaButton: UIButton = .init()
    var accountButton: UIButton = .init()
    var accountStatusLabel: UILabel = .init()
    var jumpButton: UIButton = .init()
    let vStack = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        let captchaStack = UIStackView()
        captchaStack.spacing = 15
        captchaTextField.borderStyle = .roundedRect
        getCaptchaButton.configuration = .gray()
        getCaptchaButton.addTarget(self, action: #selector(clickGetCaptchaButton), for: .touchUpInside)

        captchaStack.addArrangedSubview(captchaTextField)
        captchaStack.addArrangedSubview(getCaptchaButton)
        NSLayoutConstraint.activate([
            captchaTextField.widthAnchor.constraint(equalTo: captchaStack.widthAnchor, multiplier: 0.5),
        ])

        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.spacing = 15
        vStack.axis = .vertical
        vStack.alignment = .center
        addSubview(vStack)

        emailTextField.borderStyle = .roundedRect
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        accountButton.configuration = .filled()
        accountButton.addTarget(self, action: #selector(clickAccountButton), for: .touchUpInside)

        vStack.addArrangedSubview(emailTextField)
        vStack.addArrangedSubview(passwordTextField)
        vStack.addArrangedSubview(captchaStack)
        vStack.addArrangedSubview(accountButton)

        NSLayoutConstraint.activate([
            vStack.leftAnchor.constraint(equalTo: leftAnchor, constant: 60),
            vStack.rightAnchor.constraint(equalTo: rightAnchor, constant: -60),
            accountButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            emailTextField.widthAnchor.constraint(equalTo: vStack.widthAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: vStack.widthAnchor),
            captchaStack.widthAnchor.constraint(equalTo: vStack.widthAnchor),
            accountButton.widthAnchor.constraint(equalTo: vStack.widthAnchor),
        ])
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func genJumpStack(isOn: Bool, labelText: String, buttonTitle: String) {
        if !isOn { return }
        let jumpStack = UIStackView()
        jumpStack.spacing = 0
        accountStatusLabel.text = labelText
        jumpButton.configuration = .plain()
        jumpButton.setTitle(buttonTitle, for: .normal)
        jumpButton.addTarget(self, action: #selector(clickJumpButton(_:)), for: .touchUpInside)
        jumpStack.addArrangedSubview(accountStatusLabel)
        jumpStack.addArrangedSubview(jumpButton)
        vStack.addArrangedSubview(jumpStack)
    }

    func setText(textFieldText1: String, textFieldText2: String, buttonTitle: String) {
        emailTextField.placeholder = textFieldText1
        emailTextField.spellCheckingType = .no
        passwordTextField.placeholder = textFieldText2
        captchaTextField.placeholder = "验证码"
        getCaptchaButton.setTitle("获取验证码", for: .normal)
        accountButton.setTitle(buttonTitle, for: .normal)
    }

    @objc func clickJumpButton(_: UIButton) {
        delegate?.clickJumpButton(self)
    }

    @objc func clickAccountButton(_: UIButton) {
        delegate?.clickAccountButton(self)
    }

    @objc func clickGetCaptchaButton(_: UIButton) {
        delegate?.clickGetCaptchaButton(self)
    }
}
