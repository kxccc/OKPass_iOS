//
//  RegisterVC.swift
//  OKPass
//
//  Created by 陈治成 on 2022/7/7.
//

import UIKit

class RegisterVC: LoginVC {

    override func genJumpStack() -> UIStackView {
        let jumpStack = UIStackView()
        jumpStack.spacing = 0
        accountStatusLabel.text = "已有账号？"
        jumpButton.configuration = UIButton.Configuration.plain()
        jumpButton.setTitle("立即登陆", for: .normal)
        jumpButton.addTarget(self, action: #selector(clickJumpButton), for: .touchUpInside)
        jumpStack.addArrangedSubview(accountStatusLabel)
        jumpStack.addArrangedSubview(jumpButton)
        return jumpStack
    }
    
    override func setText() {
        self.title = "注册"
        emailTextField.placeholder = "邮箱"
        passwordTextField.placeholder = "密码"
        captchaTextField.placeholder = "验证码"
        getCaptchaButton.setTitle("获取验证码", for: .normal)
        accountButton.setTitle("注册", for: .normal)
    }
 
    
    @objc override func clickJumpButton() {
        navigationController?.popViewController(animated: true)
    }
   

}
