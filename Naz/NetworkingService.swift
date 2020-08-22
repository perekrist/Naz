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
import SVProgressHUD

class Auth: ObservableObject {
    var baseURL = "http://i-fan.herokuapp.com/"
    
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
    
}

class NetworkService: ObservableObject {
    var baseURL = "http://i-fan.herokuapp.com/"
    
    var events: [Event] = [Event(name: "СОЧИ - УРАЛ", date: 1598817600, place: "Стадион Фишт", id: 90)]
    //    var events: [Event] = []
    init() {
        getEvents()
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
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
    
}

class Sectors: ObservableObject {
    var baseURL = "http://i-fan.herokuapp.com/"
    var sectors: [Sector] = []
    
    init() {
        getSections(id: 90, completion: {
            print("sectors")
        })
    }
    
    func getSections(id: Int, completion: @escaping () -> Void) {
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
                    completion()
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
}

class Places:  ObservableObject {
    var baseURL = "http://i-fan.herokuapp.com/"
    
    var places: [Place] = []
    
    func getPlaces(event_id: Int, sector_id: Int, completion: @escaping () -> Void) {
        AF.request(baseURL + "events/\(event_id)/\(sector_id)",
            method: .get,
            encoding: URLEncoding.default)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success:
                    let json = try! JSON(data: response.data!)
                    if json != "" {
                        self.places.removeAll()
                        let result = json["result"].arrayValue
                        for i in result {
                            self.places.append(Place(row: i[0].intValue, place: i[1].intValue))
                        }
                    }
                    completion()
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
}

class ReserveTicket:  ObservableObject {
    var baseURL = "http://i-fan.herokuapp.com/"
    
    func reserbe(event_id: Int, sector_id: Int, row: Int, place: Int, completion: @escaping () -> Void) {
        let token = UserDefaults.standard.string(forKey: "token")
        
        let parameters: Parameters = ["game": event_id,
                                      "sector": sector_id,
                                      "row": row,
                                      "place": place,
                                      "token": token]
        
        
        AF.request(baseURL + "/ticket/new",
                   method: .get,
                   parameters: parameters,
                   encoding: URLEncoding.default)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success:
                    print(response.result)
                    completion()
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
}

