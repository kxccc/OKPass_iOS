//
//  RegisterVC.swift
//  OKPass
//
//  Created by 陈治成 on 2022/7/7.
//

import PKHUD
import UIKit

class RegisterVC: LoginVC {
//    override func viewWillAppear(_: Bool) {}
//
//    override func genJumpStack() -> UIStackView {
//        let jumpStack = UIStackView()
//        jumpStack.spacing = 0
//        accountStatusLabel.text = "已有账号？"
//        jumpButton.configuration = UIButton.Configuration.plain()
//        jumpButton.setTitle("立即登陆", for: .normal)
//        jumpButton.addTarget(self, action: #selector(clickJumpButton), for: .touchUpInside)
//        jumpStack.addArrangedSubview(accountStatusLabel)
//        jumpStack.addArrangedSubview(jumpButton)
//        return jumpStack
//    }
//
//    override func setText() {
//        title = "注册"
//        emailTextField.placeholder = "邮箱"
//        emailTextField.spellCheckingType = .no
//        passwordTextField.placeholder = "密码"
//        captchaTextField.placeholder = "验证码"
//        getCaptchaButton.setTitle("获取验证码", for: .normal)
//        accountButton.setTitle("注册", for: .normal)
//    }
//
//    @objc override func clickJumpButton() {
//        navigationController?.popViewController(animated: true)
//    }
//
//    @objc override func clickAccountButton() {
//        let email = emailTextField.text ?? ""
//        if email.isEmpty {
//            HUD.flash(.label("请输入邮箱"), delay: 0.5)
//            return
//        }
//        let password = passwordTextField.text ?? ""
//        if password.isEmpty {
//            HUD.flash(.label("请输入密码"), delay: 0.5)
//            return
//        }
//        let captcha = captchaTextField.text ?? ""
//        if captcha.isEmpty {
//            HUD.flash(.label("请输入验证码"), delay: 0.5)
//            return
//        }
//
//        NetworkAPI.register(email: email, password: password, captcha: captcha, completion: { [weak self] Result in
//            guard let self = self else { return }
//            switch Result {
//            case let .success(res):
//                if res.status {
//                    HUD.flash(.label("注册成功"), delay: 1)
//                    self.navigationController?.popViewController(animated: true)
//                } else {
//                    HUD.flash(.label(res.msg), delay: 0.5)
//                }
//            case let .failure(error):
//                HUD.flash(.label(error.localizedDescription), delay: 0.5)
//            }
//        })
//    }
//
//    @objc override func clickGetCaptchaButton() {
//        let email = emailTextField.text ?? ""
//        if email.isEmpty {
//            HUD.flash(.label("请输入邮箱"), delay: 0.5)
//            return
//        }
//
//        NetworkAPI.getRegisterCaptcha(email: email, completion: { [weak self] Result in
//            guard let self = self else { return }
//            switch Result {
//            case let .success(res):
//                if res.status {
//                    self.isCounting = true
//                } else {
//                    HUD.flash(.label(res.msg), delay: 0.5)
//                }
//            case let .failure(error):
//                HUD.flash(.label(error.localizedDescription), delay: 0.5)
//            }
//        })
//    }
}
