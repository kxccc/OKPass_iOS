//
//  LoginVC.swift
//  OKPass
//
//  Created by 陈治成 on 2022/7/6.
//

import UIKit

class LoginVC: UIViewController {
    private var errorLabel: UILabel!
    private var emailTextField: UITextField!
    private var passwordTextField: UITextField!
    private var captchaTextField: UITextField!
    private var getCaptchaButton: UIButton!
    private var loginButton: UIButton!
    private var accountStatusLabel: UILabel!
    private var jumpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        errorLabel = UILabel()
        emailTextField = UITextField()
        passwordTextField = UITextField()
        captchaTextField = UITextField()
        getCaptchaButton = UIButton()
        loginButton = UIButton()
        accountStatusLabel = UILabel()
        jumpButton = UIButton()
        
        
        let captchaStack = UIStackView()
        captchaStack.spacing = 15
        captchaTextField.placeholder = "验证码"
        captchaTextField.borderStyle = .roundedRect
        getCaptchaButton.configuration = UIButton.Configuration.gray()
        getCaptchaButton.setTitle("获取验证码", for: .normal)
        captchaStack.addArrangedSubview(captchaTextField)
        captchaStack.addArrangedSubview(getCaptchaButton)
        NSLayoutConstraint.activate([
            captchaTextField.widthAnchor.constraint(equalTo: captchaStack.widthAnchor, multiplier: 0.5)
        ])
        
        
        let jumpStack = genJumpStack()
        
        
        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.spacing = 15
        vStack.axis = .vertical
        vStack.alignment = .center
        view.addSubview(vStack)
        
        errorLabel.text = "123"
        errorLabel.textColor = .red
        errorLabel.textAlignment = .center
        emailTextField.placeholder = "邮箱"
        emailTextField.borderStyle = .roundedRect
        passwordTextField.placeholder = "密码"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        loginButton.configuration = UIButton.Configuration.filled()
        loginButton.setTitle("登录", for: .normal)
        
        vStack.addArrangedSubview(errorLabel)
        vStack.addArrangedSubview(emailTextField)
        vStack.addArrangedSubview(passwordTextField)
        vStack.addArrangedSubview(captchaStack)
        vStack.addArrangedSubview(loginButton)
        vStack.addArrangedSubview(jumpStack)
        
        NSLayoutConstraint.activate([
            vStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 60),
            vStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -60),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            errorLabel.widthAnchor.constraint(equalTo: vStack.widthAnchor),
            emailTextField.widthAnchor.constraint(equalTo: vStack.widthAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: vStack.widthAnchor),
            captchaStack.widthAnchor.constraint(equalTo: vStack.widthAnchor),
            loginButton.widthAnchor.constraint(equalTo: vStack.widthAnchor),
        ])
    }
    
    func genJumpStack() -> UIStackView {
        let jumpStack = UIStackView()
        jumpStack.spacing = 0
        accountStatusLabel.text = "没有账号？"
        jumpButton.configuration = UIButton.Configuration.plain()
        jumpButton.setTitle("现在注册", for: .normal)
        jumpStack.addArrangedSubview(accountStatusLabel)
        jumpStack.addArrangedSubview(jumpButton)
        return jumpStack
    }
    
    
}

