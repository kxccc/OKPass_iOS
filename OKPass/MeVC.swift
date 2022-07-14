//
//  MeVC.swift
//  OKPass
//
//  Created by 陈治成 on 2022/7/7.
//

import UIKit

class MeVC: UIViewController {
    private var v: MeView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground

        v = MeView()
        v.delegate = self
        view.addSubview(v)
    }

    override func viewWillAppear(_: Bool) {
        tabBarController?.tabBar.isHidden = false
    }

    override func viewWillLayoutSubviews() {
        v.frame = CGRect(x: view.safeAreaInsets.left,
                         y: view.safeAreaInsets.top,
                         width: view.bounds.width - view.safeAreaInsets.left - view.safeAreaInsets.right,
                         height: view.bounds.height - view.safeAreaInsets.bottom - view.safeAreaInsets.top)
    }
}

extension MeVC: MeViewDelegate {
    func clickLogoutButton(_: MeView) {
        UserInfoManager.shared.logout()
    }

    func clickChangePasswordButton(_: MeView) {
        tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(ChangePasswordVC(), animated: true)
    }

    func clickBiometricsSwitch(_ senderView: MeView) {
        if senderView.biometricsSwitch.isOn {
            Biometrics.shared.authorizeBiometrics(completion: { Result in
                DispatchQueue.main.async {
                    switch Result {
                    case .success:
                        break
                    case .failure:
                        senderView.biometricsSwitch.isOn = false
                    }
                    UserInfoManager.shared.userInfo.enableBiometrics = senderView.biometricsSwitch.isOn
                    UserInfoManager.shared.save()
                }
            })
        } else {
            UserInfoManager.shared.userInfo.enableBiometrics = senderView.biometricsSwitch.isOn
            UserInfoManager.shared.save()
        }
    }
}
