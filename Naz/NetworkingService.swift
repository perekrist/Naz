//
//  NetworkingService.swift
//  Naz
//
//  Created by Кристина Перегудова on 22.08.2020.
//  Copyright © 2020 Кристина Перегудова. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkService: ObservableObject {
    var baseURL = "http://i-fan.herokuapp.com/"
    
    func signIn(login: String, password: String, completion: @escaping () -> Void) {
        
        let parameters: Parameters = ["login": login,
                                      "password": password]
        
        AF.request(baseURL + "signin",
                   method: .post,
                   parameters: parameters,
                   encoding: URLEncoding.default).responseData { (data) in
                    
                    if data.data != nil {
                        let json = try! JSON(data: data.data!)
                        print(json)
                        if json != "" {
                            UserDefaults.standard.set(true, forKey: "isLogIned")
                            completion()
                        }
                    }
                    
        }
        
    }
    
    func signUp(login: String, email: String, password: String, completion: @escaping () -> Void) {
        let id = (10000 ..< 99999).randomElement()
        UserDefaults.standard.set(id, forKey: "id")
        
        let parameters: Parameters = ["login": login,
                                      "email": email,
                                      "pwd": password,
                                      "id": id]
        
//        AF.request(baseURL + "sign-up",
//                   method: .post,
//                   parameters: parameters,
//                   encoding: URLEncoding.default).responseData { (data) in
//
//                    print(data.data)
//                    if data.data != nil {
//                        let json = try! JSON(data: data.data!)
//                        print(json)
//                        if json != "" {
//                            UserDefaults.standard.set(true, forKey: "isLogIned")
//                            completion()
//                        }
//                    }
//
//        }
        AF.request(baseURL + "sign-up",
        method: .post,
        parameters: parameters,
        encoding: URLEncoding.default)
        .validate().responseJSON() { response in
            switch response.result {
            case .failure:
                if let statusCode = response.response?.statusCode {
                    if statusCode == 409 {
                        // handle 409 specific error here, if you want
                    }
                }
            case .success(let value):
                // handle success here
                print(value)
            }
        }
        
    }
}

