//
//  PasswordManager.swift
//  OKPass
//
//  Created by 陈治成 on 2022/7/10.
//

import PKHUD
import RNCryptor
import UIKit

class PasswordManager {
    static let shared = PasswordManager()

    var categoryList: [String] = []
    var password: [String: [Password]] = [:]
    var key = UserInfoManager.shared.userInfo.key
    var token = UserInfoManager.shared.userInfo.token

    private init() {}

    func decrypt(data: [Password]) {
        categoryList.removeAll()
        password.removeAll()
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
        var res = "解密错误"
        do {
            guard let ciphertext = Data(base64Encoded: ciphertext) else { return res }
            let originalData = try RNCryptor.decrypt(data: ciphertext, withPassword: key)
            res = String(data: originalData, encoding: .utf8)!
        } catch {
            print(error)
        }
        return res
    }

    func encryptWithKey(_ plaintext: String) -> String {
        let data: Data = plaintext.data(using: .utf8)!
        let ciphertext = RNCryptor.encrypt(data: data, withPassword: key)
        let res: String = ciphertext.base64EncodedString()

        return res
    }

    func delPassword(category: String, index: Int, completion: @escaping () -> Void) {
        let id = password[category]?[index].id ?? -1
        NetworkAPI.delPassword(token: token, id: id, completion: { [weak self] Result in
            guard let self = self else { return }
            switch Result {
            case let .success(res):
                if res.status {
                    self.password[category]?.remove(at: index)
                    completion()
                } else {
                    HUD.flash(.label(res.msg), delay: 0.5)
                }
            case let .failure(error):
                HUD.flash(.label(error.localizedDescription), delay: 0.5)
            }

        })
    }

    func addPassword(title: String, url: String, username: String, password: String, remark: String, category: String, completion: @escaping () -> Void) {
        let encryptedTitle = encryptWithKey(title)
        let encryptedUrl = encryptWithKey(url)
        let encryptedUsername = encryptWithKey(username)
        let encryptedPassword = encryptWithKey(password)
        let encryptedRemark = encryptWithKey(remark)
        let encryptedCategory = encryptWithKey(category)

        NetworkAPI.addPassword(token: token, title: encryptedTitle, url: encryptedUrl, username: encryptedUsername, password: encryptedPassword, remark: encryptedRemark, category: encryptedCategory, completion: { [weak self] Result in
            guard let self = self else { return }
            switch Result {
            case let .success(res):
                if res.status {
                    let newPassword = Password()
                    newPassword.id = res.id!
                    newPassword.title = title
                    newPassword.url = url
                    newPassword.username = username
                    newPassword.password = password
                    newPassword.remark = remark
                    newPassword.category = category
                    if !self.password.keys.contains(category) {
                        self.categoryList.insert(category, at: 0)
                        self.password.updateValue([], forKey: category)
                    }
                    self.password[category]?.insert(newPassword, at: 0)
                    completion()
                } else {
                    HUD.flash(.label(res.msg), delay: 0.5)
                }
            case let .failure(error):
                HUD.flash(.label(error.localizedDescription), delay: 0.5)
            }
        })
    }
}
