//
//  MeVC.swift
//  OKPass
//
//  Created by 陈治成 on 2022/7/7.
//

import UIKit

class MeVC: UIViewController {
    private var avatarImageView: UIImageView!
    private var userLabel: UILabel!
    private var biometricsLabel: UILabel!
    private var biometricsSwitch: UISwitch!
    private var changePasswordButton: UIButton!
    private var logoutButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        avatarImageView = UIImageView()
        userLabel = UILabel()
        biometricsLabel = UILabel()
        biometricsSwitch = UISwitch()
        changePasswordButton = UIButton()
        logoutButton = UIButton()

        let biometricsStack = UIStackView()
        biometricsStack.spacing = 0
        biometricsStack.addArrangedSubview(biometricsLabel)
        biometricsStack.addArrangedSubview(biometricsSwitch)

        avatarImageView.image = UIImage(systemName: "person.circle.fill")
        avatarImageView.contentMode = .scaleAspectFit
        userLabel.text = UserInfoManager.shared.userInfo.user
        userLabel.font = UIFont.systemFont(ofSize: 25)
        biometricsLabel.text = "启用生物识别验证"
        biometricsSwitch.isEnabled = Biometrics.shared.canEvaluatePolicy()
        biometricsSwitch.isOn = UserInfoManager.shared.userInfo.enableBiometrics
        biometricsSwitch.addTarget(self, action: #selector(clickBiometricsSwitch), for: .touchUpInside)
        changePasswordButton.configuration = UIButton.Configuration.gray()
        changePasswordButton.setTitle("修改登录密码", for: .normal)
        changePasswordButton.addTarget(self, action: #selector(clickChangePasswordButton), for: .touchUpInside)
        logoutButton.configuration = UIButton.Configuration.filled()
        logoutButton.setTitle("退出登录", for: .normal)
        logoutButton.tintColor = .red
        logoutButton.addTarget(self, action: #selector(clickLogoutButton), for: .touchUpInside)

        let vStack = UIStackView()
        view.addSubview(vStack)
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.spacing = 15
        vStack.axis = .vertical
        vStack.alignment = .center
        vStack.addArrangedSubview(avatarImageView)
        vStack.addArrangedSubview(userLabel)
        vStack.addArrangedSubview(biometricsStack)
        vStack.addArrangedSubview(changePasswordButton)
        vStack.addArrangedSubview(logoutButton)

        NSLayoutConstraint.activate([
            vStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 60),
            vStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -60),
            vStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 150),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            biometricsStack.widthAnchor.constraint(equalTo: vStack.widthAnchor),
            changePasswordButton.widthAnchor.constraint(equalTo: vStack.widthAnchor),
            logoutButton.widthAnchor.constraint(equalTo: vStack.widthAnchor),
        ])
    }

    @objc func clickLogoutButton() {
        UserInfoManager.shared.logout()
    }

    @objc func clickChangePasswordButton() {
        navigationController?.pushViewController(ChangePasswordVC(), animated: true)
    }

    @objc func clickBiometricsSwitch() {
        if biometricsSwitch.isOn {
            Biometrics.shared.authorizeBiometrics(completion: { [weak self] Result in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    switch Result {
                    case .success:
                        break
                    case .failure:
                        self.biometricsSwitch.isOn = false
                    }
                    UserInfoManager.shared.userInfo.enableBiometrics = self.biometricsSwitch.isOn
                    UserInfoManager.shared.save()
                }
            })
        } else {
            UserInfoManager.shared.userInfo.enableBiometrics = biometricsSwitch.isOn
            UserInfoManager.shared.save()
        }
    }
}
