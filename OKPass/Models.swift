//
//  Models.swift
//  OKPass
//
//  Created by 陈治成 on 2022/7/7.
//

class GeneralRes: Codable {
    var status: Bool
    var msg: String
}

class LoginRes: Codable {
    var status: Bool
    var msg: String
    var data: LoginResData?
    class LoginResData: Codable {
        var token: String
        var key: String
    }
}

class AddPasswordRes: Codable {
    var status: Bool
    var msg: String
    var id: Int?
}

class GetPasswordRes: Codable {
    var status: Bool
    var msg: String
    var data: [Password]?
}

class Password: Codable {
    var id: Int = -1
    var title: String = ""
    var url: String = ""
    var username: String = ""
    var password: String = ""
    var remark: String = ""
    var category: String = ""
}

class UserInfo: Codable {
    var user: String = ""
    var token: String = ""
    var key: String = ""
    var enableBiometrics: Bool = false
}
