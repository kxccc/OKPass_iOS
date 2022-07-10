//
//  PasswordManager.swift
//  OKPass
//
//  Created by 陈治成 on 2022/7/10.
//

import RNCryptor
import UIKit

class PasswordManager {
    static let shared = PasswordManager()

    var categoryList: [String] = []
    var password: [String: [Password]] = [:]
    var key = UserInfoManager.shared.userInfo.key

    private init() {}

    func decrypt(data _: [Password]) {
        for i in 0 ..< 18 {
            let item = Password()
            let fake = "\(i)"
            item.id = i
            item.title = fake + "标题标题"
            item.url = fake + "url"
            item.username = fake + "用户名"
            item.password = fake + "密码"
            item.remark = fake
            item.category = "\(i % 9)哈哈哈"
            if !password.keys.contains(item.category) {
                categoryList.append(item.category)
                password.updateValue([], forKey: item.category)
            }
            password[item.category]?.append(item)
        }
    }

    func decrypt1(data: [Password]) {
        for i in data {
            let item = Password()
            item.id = i.id
            item.title = decryptWithKey(i.title)
            item.url = decryptWithKey(i.url)
            item.username = decryptWithKey(i.username)
            item.password = decryptWithKey(i.password)
            item.remark = decryptWithKey(i.remark)
            item.category = decryptWithKey(i.category)
            if !password.keys.contains(item.category) {
                categoryList.append(item.category)
                password.updateValue([], forKey: item.category)
            }
            password[item.category]?.append(item)
        }
    }

    func decryptWithKey(_ ciphertext: String) -> String {
        let ciphertext = Data(base64Encoded: ciphertext)!
        var res = "解密错误"
        do {
            let originalData = try RNCryptor.decrypt(data: ciphertext, withPassword: key)
            res = String(data: originalData, encoding: .utf8)!
        } catch {
            print(error)
        }
        return res
    }

    func delPassword(category: String, index: Int) {
        password[category]?.remove(at: index)
    }
}
