//
//  LightPerfView.swift
//  Naz
//
//  Created by Кристина Перегудова on 23.08.2020.
//  Copyright © 2020 Кристина Перегудова. All rights reserved.
//

import SwiftUI

struct LightPerfView: View {
    @State var time: Int
    @State var back = false
    
    @State var timeLeft = 0
    
    //    var lightPerf = LighthPerformance()
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            //            self.timeLeft = self.getRemTime()
            //            print(self.timeLeft)
            if self.timeLeft > 0 {
                self.timeLeft = self.timeLeft - 1
            }
        }
    }
    
    var body: some View {
        ZStack {
            Colors.grey.edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Button(action: {
                        self.back.toggle()
                    }) {
                        Image(systemName: "arrow.left.square.fill")
                            .foregroundColor(Colors.yellow)
                    }.padding(.leading, 60)
                    Spacer()
                }
                Text("Дата начала: \(Date(timeIntervalSince1970: TimeInterval(self.time)))")
                    .padding()
                    .foregroundColor(Colors.blue)
                
                Text("До начала осталось \(timeLeft) секунд")
                    .padding()
                    .foregroundColor(Colors.blue)
                    .onAppear(perform: {
                        _ = self.timer
                    })
                
                Spacer()
            }
        }
        .onAppear {
            self.timeLeft = self.getRemTime()
        }
        .navigate(to: BottomMenu(), when: $back)
    }
    
    func getRemTime() -> Int {
        let timestamp = NSDate().timeIntervalSince1970
        print(timestamp)
        return Int(time - Int(timestamp))
    }
}
