//
//  ChangePasswordVC.swift
//  OKPass
//
//  Created by 陈治成 on 2022/7/9.
//
import PKHUD
import UIKit

class ChangePasswordVC: LoginVC {
    override func viewDidLoad() {
        superViewDidLoad()

        view.backgroundColor = UIColor.systemBackground

        title = "修改登录密码"
        v.delegate = self
        v.genJumpStack(isOn: false, labelText: "", buttonTitle: "")
        v.setText(textFieldText1: "原密码", textFieldText2: "新密码", buttonTitle: "修改")
        v.emailTextField.isSecureTextEntry = true
        view.addSubview(v)
    }

    override func viewWillAppear(_: Bool) {}
}

extension ChangePasswordVC {
    override func clickAccountButton(_ senderView: LoginView) {
        let old_password = senderView.emailTextField.text ?? ""
        if old_password.isEmpty {
            HUD.flash(.label("请输入原密码"), delay: 0.5)
            return
        }
        let new_password = senderView.passwordTextField.text ?? ""
        if new_password.isEmpty {
            HUD.flash(.label("请输入新密码"), delay: 0.5)
            return
        }
        let captcha = senderView.captchaTextField.text ?? ""
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

    override func clickGetCaptchaButton(_: LoginView) {
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
