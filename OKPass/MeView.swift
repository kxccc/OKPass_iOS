//
//  MeView.swift
//  OKPass
//
//  Created by 陈治成 on 2022/7/13.
//

import UIKit

protocol MeViewDelegate: AnyObject {
    func clickLogoutButton(_ senderView: MeView)
    func clickChangePasswordButton(_ senderView: MeView)
    func clickBiometricsSwitch(_ senderView: MeView)
}

@IBDesignable class MeView: UIView {
    weak var delegate: MeViewDelegate?

    private var avatarImageView: UIImageView = .init()
    private var userLabel: UILabel = .init()
    private var biometricsLabel: UILabel = .init()
    var biometricsSwitch: UISwitch = .init()
    private var changePasswordButton: UIButton = .init()
    private var logoutButton: UIButton = .init()

    override init(frame: CGRect) {
        super.init(frame: frame)

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
        changePasswordButton.configuration = .gray()
        changePasswordButton.setTitle("修改登录密码", for: .normal)
        changePasswordButton.addTarget(self, action: #selector(clickChangePasswordButton), for: .touchUpInside)
        logoutButton.configuration = .filled()
        logoutButton.setTitle("退出登录", for: .normal)
        logoutButton.tintColor = .red
        logoutButton.addTarget(self, action: #selector(clickLogoutButton), for: .touchUpInside)

        let vStack = UIStackView()
        addSubview(vStack)
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
            vStack.leftAnchor.constraint(equalTo: leftAnchor, constant: 60),
            vStack.rightAnchor.constraint(equalTo: rightAnchor, constant: -60),
            vStack.topAnchor.constraint(equalTo: topAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 150),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            biometricsStack.widthAnchor.constraint(equalTo: vStack.widthAnchor),
            changePasswordButton.widthAnchor.constraint(equalTo: vStack.widthAnchor),
            logoutButton.widthAnchor.constraint(equalTo: vStack.widthAnchor),
        ])
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func clickLogoutButton() {
        delegate?.clickLogoutButton(self)
    }

    @objc func clickChangePasswordButton() {
        delegate?.clickChangePasswordButton(self)
    }

    @objc func clickBiometricsSwitch() {
        delegate?.clickBiometricsSwitch(self)
    }
}
