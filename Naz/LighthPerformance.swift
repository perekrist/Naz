//
//  LighthPerformance.swift
//  Naz
//
//  Created by Кристина Перегудова on 23.08.2020.
//  Copyright © 2020 Кристина Перегудова. All rights reserved.
//

import Foundation
import SwiftUI

class LighthPerformance {
    var timer: Timer?
    
    func getRemTime(time: Int) -> Int {
        let timestamp = NSDate().timeIntervalSince1970
        print(timestamp)
        return Int(time - Int(timestamp))
    }
    
    func start() {
        UIScreen.main.brightness = 1
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(start_2),
                                     userInfo: nil,
                                     repeats: false)
    }
    
    @objc func start_2(){
        UIScreen.main.brightness = 0
        timer = Timer.scheduledTimer(timeInterval: 0.5,
                                     target: self,
                                     selector: #selector(start_3),
                                     userInfo: nil,
                                     repeats: false)
    }
    
    @objc func start_3(){
        UIScreen.main.brightness = 1
    }
}
