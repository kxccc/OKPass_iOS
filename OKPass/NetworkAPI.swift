//
//  NetworkAPI.swift
//  OKPass
//
//  Created by 陈治成 on 2022/7/8.
//

import Alamofire
import Foundation

private let baseUrl = "https://gxuoj.cf:666/"

class NetworkAPI {

    static func getLoginCaptcha(email: String, completion: @escaping (Result<GeneralRes, Error>) -> Void) {
        let url = baseUrl + "api/captcha"
        AF.request(url,
                   method: .post,
                   parameters: ["email": email],
                   encoding: JSONEncoding.default
        ).responseData { response in
            switch response.result {
            case let .success(data):
                if let res = try? JSONDecoder().decode(GeneralRes.self, from:data) {
                    completion(.success(res))
                }
                else{
                    let error = NSError(domain: "NetworkAPIDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Decode error"])
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
       
    }
    

}