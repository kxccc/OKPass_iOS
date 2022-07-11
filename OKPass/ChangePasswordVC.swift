//
//  ChangePasswordVC.swift
//  OKPass
//
//  Created by 陈治成 on 2022/7/9.
//
import PKHUD
import UIKit

class ChangePasswordVC: LoginVC {
    override func viewWillAppear(_: Bool) {}

    override func genJumpStack() -> UIStackView {
        let jumpStack = UIStackView()
        return jumpStack
    }

    override func setText() {
        title = "修改登录密码"
        emailTextField.placeholder = "原密码"
        emailTextField.isSecureTextEntry = true
        passwordTextField.placeholder = "新密码"
        captchaTextField.placeholder = "验证码"
        getCaptchaButton.setTitle("获取验证码", for: .normal)
        accountButton.setTitle("修改", for: .normal)
    }

    @objc override func clickAccountButton() {
        let old_password = emailTextField.text ?? ""
        if old_password.isEmpty {
            HUD.flash(.label("请输入原密码"), delay: 0.5)
            return
        }
        let new_password = passwordTextField.text ?? ""
        if new_password.isEmpty {
            HUD.flash(.label("请输入新密码"), delay: 0.5)
            return
        }
        let captcha = captchaTextField.text ?? ""
        if captcha.isEmpty {
            HUD.flash(.label("请输入验证码"), delay: 0.5)
            return
        }

        NetworkAPI.changeLoginPassword(token: UserInfoManager.shared.userInfo.token, old_password: old_password, new_password: new_password, captcha: captcha, completion: { Result in
            switch Result {
            case let .success(res):
                if res.status {
                    UserInfoManager.shared.logout()
                } else {
                    HUD.flash(.label(res.msg), delay: 0.5)
                }
            case let .failure(error):
                HUD.flash(.label(error.localizedDescription), delay: 0.5)
            }
        })
    }

    @objc override func clickGetCaptchaButton() {
        let email = UserInfoManager.shared.userInfo.user

        NetworkAPI.getLoginCaptcha(email: email, completion: { [weak self] Result in
            guard let self = self else { return }
            switch Result {
            case let .success(res):
                if res.status {
                    self.isCounting = true
                } else {
                    HUD.flash(.label(res.msg), delay: 0.5)
                }
            case let .failure(error):
                HUD.flash(.label(error.localizedDescription), delay: 0.5)
            }
        })
    }
}
