//
//  NetworkAPI.swift
//  OKPass
//
//  Created by 陈治成 on 2022/7/8.
//

import Alamofire
import Foundation

private let baseUrl = "https://gxuoj.cf:666/"

enum NetworkAPI {
    static func getLoginCaptcha(email: String, completion: @escaping (Result<GeneralRes, Error>) -> Void) {
        let url = baseUrl + "api/captcha"
        AF.request(url,
                   method: .post,
                   parameters: ["email": email],
                   encoding: JSONEncoding.default).responseData { response in
            switch response.result {
            case let .success(data):
                if let res = try? JSONDecoder().decode(GeneralRes.self, from: data) {
                    completion(.success(res))
                } else {
                    let error = NSError(domain: "NetworkAPIDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Decode error"])
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    static func Login(email: String, password: String, captcha: String, completion: @escaping (Result<LoginRes, Error>) -> Void) {
        let url = baseUrl + "api/login"
        AF.request(url,
                   method: .post,
                   parameters: ["email": email,
                                "password": password,
                                "captcha": captcha],
                   encoding: JSONEncoding.default).responseData { response in
            switch response.result {
            case let .success(data):
                if let res = try? JSONDecoder().decode(LoginRes.self, from: data) {
                    completion(.success(res))
                } else {
                    let error = NSError(domain: "NetworkAPIDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Decode error"])
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    static func getRegisterCaptcha(email: String, completion: @escaping (Result<GeneralRes, Error>) -> Void) {
        let url = baseUrl + "api/register-captcha"
        AF.request(url,
                   method: .post,
                   parameters: ["email": email],
                   encoding: JSONEncoding.default).responseData { response in
            switch response.result {
            case let .success(data):
                if let res = try? JSONDecoder().decode(GeneralRes.self, from: data) {
                    completion(.success(res))
                } else {
                    let error = NSError(domain: "NetworkAPIDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Decode error"])
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    static func register(email: String, password: String, captcha: String, completion: @escaping (Result<GeneralRes, Error>) -> Void) {
        let url = baseUrl + "api/register"
        AF.request(url,
                   method: .post,
                   parameters: ["email": email,
                                "password": password,
                                "captcha": captcha],
                   encoding: JSONEncoding.default).responseData { response in
            switch response.result {
            case let .success(data):
                if let res = try? JSONDecoder().decode(GeneralRes.self, from: data) {
                    completion(.success(res))
                } else {
                    let error = NSError(domain: "NetworkAPIDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Decode error"])
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    static func changePassword(token: String, old_password: String, new_password: String, captcha: String, completion: @escaping (Result<GeneralRes, Error>) -> Void) {
        let url = baseUrl + "api/passwd"
        AF.request(url,
                   method: .post,
                   parameters: ["token": token,
                                "old_password": old_password,
                                "new_password": new_password,
                                "captcha": captcha],
                   encoding: JSONEncoding.default).responseData { response in
            switch response.result {
            case let .success(data):
                if let res = try? JSONDecoder().decode(GeneralRes.self, from: data) {
                    completion(.success(res))
                } else {
                    let error = NSError(domain: "NetworkAPIDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Decode error"])
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    static func getPassword(token: String, completion: @escaping (Result<GetPasswordRes, Error>) -> Void) {
        let url = baseUrl + "api/allpassword"
        AF.request(url,
                   method: .post,
                   parameters: ["token": token],
                   encoding: JSONEncoding.default).responseData { response in
            switch response.result {
            case let .success(data):
                if let res = try? JSONDecoder().decode(GetPasswordRes.self, from: data) {
                    completion(.success(res))
                } else {
                    let error = NSError(domain: "NetworkAPIDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Decode error"])
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
