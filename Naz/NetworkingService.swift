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
    var events: [Event] = [Event(name: "СОЧИ - УРАЛ", date: 1598817600, place: "Стадион Фишт", id: 90)]
    var sectors: [Sector] = [Sector(name: "Сектор А101", cost: 1300, freePlaces: 125, id: 9090)]
    
    init() {
        getEvents()
        getSections(id: 90)
    }
    
    func signIn(login: String, password: String, completion: @escaping () -> Void) {
        
        let parameters: Parameters = ["login": login,
                                      "pwd": password]
        
        AF.request(baseURL + "sign-in",
                   method: .post,
                   parameters: parameters,
                   encoding: URLEncoding.default)
            .validate(statusCode: 200..<300)
            .response { response in
                switch response.result {
                case .success:
                    print(response)
                    UserDefaults.standard.set(true, forKey: "isLogIned")
                case .failure(let error):
                    print(error.localizedDescription)
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
        
        AF.request(baseURL + "sign-up",
                   method: .post,
                   parameters: parameters,
                   encoding: URLEncoding.default)
            .validate(statusCode: 200..<300)
            .response { response in
                switch response.result {
                case .success:
                    print(response)
                    completion()
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
    
    func getEvents() {
        AF.request(baseURL + "events",
                   method: .get,
                   encoding: URLEncoding.default)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success:
                    let json = try! JSON(data: response.data!)
                    if json != "" {
                        let result = json["result"].arrayValue
                        for i in result {
                            self.events.append(Event(name: i[0].stringValue, date: i[1].intValue, place: i[2].stringValue, id: i[3].intValue))
                        }
                        print(self.events.count)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
    
    func confirmEmail(code: String, completion: @escaping () -> Void) {
        let id = UserDefaults.standard.integer(forKey: "id")
        print(id)
        let parameters: Parameters = ["code": code,
                                      "id": id]
        
        AF.request(baseURL + "sign-up/code",
                   method: .post,
                   parameters: parameters,
                   encoding: URLEncoding.default)
            .validate(statusCode: 200..<300)
            .response { response in
                switch response.result {
                case .success:
                    print(response)
                    UserDefaults.standard.set(true, forKey: "isLogIned")
                    completion()
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
    
    func getSections(id: Int) {
        AF.request(baseURL + "events/\(id)",
                   method: .get,
                   encoding: URLEncoding.default)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success:
                    let json = try! JSON(data: response.data!)
                    if json != "" {
                        let result = json["result"].arrayValue
                        for i in result {
                            self.sectors.append(Sector(name: i[0].stringValue, cost: i[1].doubleValue, freePlaces: i[2].intValue, id: i[3].intValue))
                        }
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
}

