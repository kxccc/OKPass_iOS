//
//  LoginVC.swift
//  OKPass
//
//  Created by 陈治成 on 2022/7/6.
//

import UIKit
import PKHUD

class LoginVC: UIViewController {
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var captchaTextField: UITextField!
    var getCaptchaButton: UIButton!
    var accountButton: UIButton!
    var accountStatusLabel: UILabel!
    var jumpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        emailTextField = UITextField()
        passwordTextField = UITextField()
        captchaTextField = UITextField()
        getCaptchaButton = UIButton()
        accountButton = UIButton()
        accountStatusLabel = UILabel()
        jumpButton = UIButton()
        
        
        let captchaStack = UIStackView()
        captchaStack.spacing = 15
        captchaTextField.borderStyle = .roundedRect
        getCaptchaButton.configuration = UIButton.Configuration.gray()
        getCaptchaButton.addTarget(self, action: #selector(clickGetCaptchaButton), for: .touchUpInside)
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
        
        emailTextField.borderStyle = .roundedRect
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        accountButton.configuration = UIButton.Configuration.filled()
        accountButton.addTarget(self, action: #selector(clickAccountButton), for: .touchUpInside)
        
        vStack.addArrangedSubview(emailTextField)
        vStack.addArrangedSubview(passwordTextField)
        vStack.addArrangedSubview(captchaStack)
        vStack.addArrangedSubview(accountButton)
        vStack.addArrangedSubview(jumpStack)
        
        setText()
        
        NSLayoutConstraint.activate([
            vStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 60),
            vStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -60),
            accountButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            emailTextField.widthAnchor.constraint(equalTo: vStack.widthAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: vStack.widthAnchor),
            captchaStack.widthAnchor.constraint(equalTo: vStack.widthAnchor),
            accountButton.widthAnchor.constraint(equalTo: vStack.widthAnchor),
        ])
    }
    
    func genJumpStack() -> UIStackView {
        let jumpStack = UIStackView()
        jumpStack.spacing = 0
        accountStatusLabel.text = "没有账号？"
        jumpButton.configuration = UIButton.Configuration.plain()
        jumpButton.setTitle("现在注册", for: .normal)
        jumpButton.addTarget(self, action: #selector(clickJumpButton), for: .touchUpInside)
        jumpStack.addArrangedSubview(accountStatusLabel)
        jumpStack.addArrangedSubview(jumpButton)
        return jumpStack
    }
    
    func setText() {
        self.title = "登录"
        emailTextField.placeholder = "邮箱"
        passwordTextField.placeholder = "密码"
        captchaTextField.placeholder = "验证码"
        getCaptchaButton.setTitle("获取验证码", for: .normal)
        accountButton.setTitle("登录", for: .normal)
    }
    
    @objc func clickJumpButton() {
        let vc = RegisterVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func clickAccountButton() {
        let vc = TabBarController()
        vc.modalPresentationStyle = .fullScreen
        navigationController?.present(vc, animated: true)
    }
    
    @objc func clickGetCaptchaButton() {
        let email = emailTextField.text ?? ""
        if email.isEmpty {
            HUD.flash(.label("请输入邮箱"), delay: 0.5)
            return
        }

        NetworkAPI.getLoginCaptcha(email: email, completion: { Result in
            switch Result {
            case let .success(res):
                if res.status {
                    print("cg")
                }
                else {
                    HUD.flash(.label(res.msg), delay: 0.5)
                }
            case let .failure(error):
                HUD.flash(.label(error.localizedDescription), delay: 0.5)
            }
        })
    }
    
}

