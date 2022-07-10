//
//  Biometrics.swift
//  OKPass
//
//  Created by 陈治成 on 2022/7/9.
//
import LocalAuthentication
import UIKit

class Biometrics {
    static let shared = Biometrics()

    let context = LAContext()
    var error: NSError?

    private init() {}

    func canEvaluatePolicy() -> Bool {
        if context.canEvaluatePolicy(
            LAPolicy.deviceOwnerAuthenticationWithBiometrics,
            error: &error
        ) {
            return true
        } else {
            return false
        }
    }

    func notifyUser(_ msg: String, err: String?) {
        print("msg > \(msg)")
        print("err > \(err ?? "no error")")
    }

    func authorizeBiometrics(completion: @escaping (Result<Int, Error>) -> Void) {
        if !canEvaluatePolicy() {
            completion(.failure(error!))
        }
        context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "请验证") { _, error in
            if let err = error {
                completion(.failure(err))
            } else {
                completion(.success(1))
            }
        }
    }

    @objc func appWillEnterForeground() {
        if UserInfoManager.shared.userInfo.enableBiometrics {
            Biometrics.shared.authorizeBiometrics(completion: { Result in
                switch Result {
                case .success: break
                case .failure:
                    DispatchQueue.main.async {
                        UserInfoManager.shared.logout()
                    }
                }
            })
        }
    }

    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(appWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }

    func removeObserver() {
        NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
    }
}

extension UIApplication {
    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)
        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)
        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}
