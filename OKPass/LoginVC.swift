//
//  LoginVC.swift
//  OKPass
//
//  Created by 陈治成 on 2022/7/6.
//

import PKHUD
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
            getCaptchaButton.isEnabled = !newValue
        }
    }

    var remainingSeconds: Int = 0 {
        willSet {
            getCaptchaButton.setTitle("\(newValue)秒", for: .normal)
            if newValue <= 0 {
                getCaptchaButton.setTitle("重新获取", for: .normal)
                isCounting = false
            }
        }
    }

    @objc func updateTime() {
        remainingSeconds -= 1
    }

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
            captchaTextField.widthAnchor.constraint(equalTo: captchaStack.widthAnchor, multiplier: 0.5),
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

    override func viewWillAppear(_: Bool) {
        if UserInfoManager.shared.load() {
            let vc = TabBarController()
            vc.modalPresentationStyle = .fullScreen
            navigationController?.present(vc, animated: true)
        }
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
        title = "登录"
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
        let email = emailTextField.text ?? ""
        if email.isEmpty {
            HUD.flash(.label("请输入邮箱"), delay: 0.5)
            return
        }
        let password = passwordTextField.text ?? ""
        if password.isEmpty {
            HUD.flash(.label("请输入密码"), delay: 0.5)
            return
        }
        let captcha = captchaTextField.text ?? ""
        if captcha.isEmpty {
            HUD.flash(.label("请输入验证码"), delay: 0.5)
            return
        }

        NetworkAPI.Login(email: email, password: password, captcha: captcha, completion: { Result in
            switch Result {
            case let .success(res):
                if res.status {
                    UserInfoManager.shared.save(user: email, token: res.data!.token, key: res.data!.key)
                    let vc = TabBarController()
                    vc.modalPresentationStyle = .fullScreen
                    self.navigationController?.present(vc, animated: true)
                } else {
                    HUD.flash(.label(res.msg), delay: 0.5)
                }
            case let .failure(error):
                HUD.flash(.label(error.localizedDescription), delay: 0.5)
            }
        })
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
