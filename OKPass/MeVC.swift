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
    private var fingerprintLabel: UILabel!
    private var fingerprintSwitch: UISwitch!
    private var changePasswordButton: UIButton!
    private var logoutButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        avatarImageView = UIImageView()
        userLabel = UILabel()
        fingerprintLabel = UILabel()
        fingerprintSwitch = UISwitch()
        changePasswordButton = UIButton()
        logoutButton = UIButton()

        let fingerprintStack = UIStackView()
        fingerprintStack.spacing = 0
        fingerprintStack.addArrangedSubview(fingerprintLabel)
        fingerprintStack.addArrangedSubview(fingerprintSwitch)

        avatarImageView.image = UIImage(systemName: "person.circle.fill")
        avatarImageView.contentMode = .scaleAspectFit
        userLabel.text = UserInfoManager.shared.userInfo.user
        userLabel.font = UIFont.systemFont(ofSize: 25)
        fingerprintLabel.text = "启用指纹验证"
        changePasswordButton.configuration = UIButton.Configuration.gray()
        changePasswordButton.setTitle("修改登录密码", for: .normal)
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
        vStack.addArrangedSubview(fingerprintStack)
        vStack.addArrangedSubview(changePasswordButton)
        vStack.addArrangedSubview(logoutButton)

        NSLayoutConstraint.activate([
            vStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 60),
            vStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -60),
            vStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 150),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            fingerprintStack.widthAnchor.constraint(equalTo: vStack.widthAnchor),
            changePasswordButton.widthAnchor.constraint(equalTo: vStack.widthAnchor),
            logoutButton.widthAnchor.constraint(equalTo: vStack.widthAnchor),
        ])
    }

    @objc func clickLogoutButton() {
        UserInfoManager.shared.remove()
        let vc = LoginVC()
        let nc = UINavigationController(rootViewController: vc)
        nc.modalPresentationStyle = .fullScreen
        navigationController?.present(nc, animated: true)
    }
}
