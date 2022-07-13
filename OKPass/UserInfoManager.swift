//
//  UserInfoManager.swift
//  OKPass
//
//  Created by 陈治成 on 2022/7/8.
//

import UIKit

class UserInfoManager {
    static let shared = UserInfoManager()
    var userInfo = UserInfo()

    private let lock = DispatchSemaphore(value: 1)

    var userInfoUrl: URL {
        var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        url.appendPathComponent("user_info.json")
        return url
    }

    private init() {}

    func login(user: String, token: String, key: String) {
        userInfo.user = user
        userInfo.token = token
        userInfo.key = key

        save()
        Biometrics.shared.addObserver()
    }

    func save() {
        if let data = try? JSONEncoder().encode(userInfo) {
            lock.wait()
            try? data.write(to: userInfoUrl)
            lock.signal()
        }
    }

    func logout() {
        try? FileManager.default.removeItem(at: userInfoUrl)
        userInfo = UserInfo()
        Biometrics.shared.removeObserver()
        UIApplication.getTopViewController()?.navigationController?.dismiss(animated: true)
    }

    func load() -> Bool {
        do {
            lock.wait()
            let data = try Data(contentsOf: userInfoUrl)

            userInfo = try JSONDecoder().decode(UserInfo.self, from: data)
            lock.signal()
            return true
        } catch {}
        lock.signal()
        return false
    }
}
