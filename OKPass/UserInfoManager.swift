//
//  UserInfoManager.swift
//  OKPass
//
//  Created by 陈治成 on 2022/7/8.
//

import UIKit

class UserInfoManager {
    static let shared = UserInfoManager()

    var userUrl: URL {
        var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        url.appendPathComponent("user.txt")
        return url
    }

    var tokenUrl: URL {
        var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        url.appendPathComponent("token.txt")
        return url
    }

    var keyUrl: URL {
        var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        url.appendPathComponent("key.txt")
        return url
    }

    func save(user: String, token: String, key: String) {
        do {
            try user.write(to: userUrl, atomically: false, encoding: .utf8)
            try token.write(to: tokenUrl, atomically: false, encoding: .utf8)
            try key.write(to: keyUrl, atomically: false, encoding: .utf8)
        } catch {}
    }
}
