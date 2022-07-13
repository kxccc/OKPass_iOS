//
//  RegisterVC.swift
//  OKPass
//
//  Created by 陈治成 on 2022/7/7.
//

import PKHUD
import UIKit

class RegisterVC: LoginVC {
    override func viewDidLoad() {
        superViewDidLoad()

        view.backgroundColor = UIColor.systemBackground

        title = "注册"
        v.delegate = self
        v.genJumpStack(isOn: true, labelText: "已有账号？", buttonTitle: "立即登陆")
        v.setText(textFieldText1: "邮箱", textFieldText2: "密码", buttonTitle: "注册")
        view.addSubview(v)
    }

    override func viewWillAppear(_: Bool) {}
}

extension RegisterVC {
    override func clickAccountButton(_ senderView: LoginView) {
        let email = senderView.emailTextField.text ?? ""
        if email.isEmpty {
            HUD.flash(.label("请输入邮箱"), delay: 0.5)
            return
        }
        let password = senderView.passwordTextField.text ?? ""
        if password.isEmpty {
            HUD.flash(.label("请输入密码"), delay: 0.5)
            return
        }
        let captcha = senderView.captchaTextField.text ?? ""
        if captcha.isEmpty {
            HUD.flash(.label("请输入验证码"), delay: 0.5)
            return
        }

        NetworkAPI.register(email: email, password: password, captcha: captcha, completion: { [weak self] Result in
            guard let self = self else { return }
            switch Result {
            case let .success(res):
                if res.status {
                    HUD.flash(.label("注册成功"), delay: 1)
                    self.navigationController?.popViewController(animated: true)
                } else {
                    HUD.flash(.label(res.msg), delay: 0.5)
                }
            case let .failure(error):
                HUD.flash(.label(error.localizedDescription), delay: 0.5)
            }
        })
    }

    override func clickJumpButton(_: LoginView) {
        navigationController?.popViewController(animated: true)
    }

    override func clickGetCaptchaButton(_ senderView: LoginView) {
        let email = senderView.emailTextField.text ?? ""
        if email.isEmpty {
            HUD.flash(.label("请输入邮箱"), delay: 0.5)
            return
        }

        NetworkAPI.getRegisterCaptcha(email: email, completion: { [weak self] Result in
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
