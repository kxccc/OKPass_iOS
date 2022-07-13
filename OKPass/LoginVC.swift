//
//  LoginVC.swift
//  OKPass
//
//  Created by 陈治成 on 2022/7/6.
//

import PKHUD
import SwiftUI
import UIKit

class LoginVC: UIViewController {
    var countdownTimer: Timer?
    var isCounting = false {
        willSet {
            if newValue {
                countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
                remainingSeconds = 60
            } else {
                countdownTimer?.invalidate()
                countdownTimer = nil
            }
            v.getCaptchaButton.isEnabled = !newValue
        }
    }

    var remainingSeconds: Int = 0 {
        willSet {
            v.getCaptchaButton.setTitle("\(newValue)秒", for: .normal)
            if newValue <= 0 {
                v.getCaptchaButton.setTitle("重新获取", for: .normal)
                isCounting = false
            }
        }
    }

    @objc func updateTime() {
        remainingSeconds -= 1
    }

    let v = LoginView()

    func superViewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidLoad() {
        superViewDidLoad()

        view.backgroundColor = UIColor.systemBackground

        title = "登录"
        v.delegate = self
        v.genJumpStack(isOn: true, labelText: "没有账号？", buttonTitle: "现在注册")
        v.setText(textFieldText1: "邮箱", textFieldText2: "密码", buttonTitle: "登录")
        view.addSubview(v)
    }

    override func viewWillLayoutSubviews() {
        v.frame = CGRect(x: view.safeAreaInsets.left,
                         y: view.safeAreaInsets.top,
                         width: view.bounds.width - view.safeAreaInsets.left - view.safeAreaInsets.right,
                         height: view.bounds.height - view.safeAreaInsets.bottom - view.safeAreaInsets.top)
    }

    override func viewWillAppear(_: Bool) {
        if UserInfoManager.shared.load() && Biometrics.shared.canEvaluatePolicy() && UserInfoManager.shared.userInfo.enableBiometrics {
            Biometrics.shared.authorizeBiometrics(completion: { [weak self] Result in
                guard let self = self else { return }
                switch Result {
                case .success:
                    DispatchQueue.main.async {
                        let vc = TabBarController()
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true)
                    }
                case .failure: break
                }
            })
        }
    }
}

@objc extension LoginVC: LoginViewDelegate {
    func clickAccountButton(_ senderView: LoginView) {
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

        NetworkAPI.Login(email: email, password: password, captcha: captcha, completion: { [weak self] Result in
            guard let self = self else { return }
            switch Result {
            case let .success(res):
                if res.status {
                    UserInfoManager.shared.login(user: email, token: res.data!.token, key: res.data!.key)
                    self.v.emailTextField.text = ""
                    self.v.passwordTextField.text = ""
                    self.v.captchaTextField.text = ""
                    let vc = TabBarController()
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true)
                } else {
                    HUD.flash(.label(res.msg), delay: 0.5)
                }
            case let .failure(error):
                HUD.flash(.label(error.localizedDescription), delay: 0.5)
            }
        })
    }

    func clickJumpButton(_: LoginView) {
        let vc = RegisterVC()
        navigationController?.pushViewController(vc, animated: true)
    }

    func clickGetCaptchaButton(_ senderView: LoginView) {
        let email = senderView.emailTextField.text ?? ""
        if email.isEmpty {
            HUD.flash(.label("请输入邮箱"), delay: 0.5)
            return
        }
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
