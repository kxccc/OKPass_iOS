//
//  Fingerprint.swift
//  OKPass
//
//  Created by 陈治成 on 2022/7/9.
//
import LocalAuthentication

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

    func authorizeBiometrics() {
        context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "请验证") { [weak self] _, error in
            guard let self = self else { return }
            if let err = error {
                switch err._code {
                case LAError.Code.systemCancel.rawValue:
                    self.notifyUser("Session cancelled", err: err.localizedDescription)
                case LAError.Code.userCancel.rawValue:
                    // 用户取消
                    self.notifyUser("Please try again", err: err.localizedDescription)
                case LAError.Code.userFallback.rawValue:
                    // 用户选择输入密码
                    self.notifyUser("Authentication", err: "Password option selected")
                default:
                    // 多次失败
                    self.notifyUser("Authentication failed", err: err.localizedDescription)
                }
            } else {
                self.notifyUser("Authentication Successful", err: "You now have full access")
            }
        }
    }
}
