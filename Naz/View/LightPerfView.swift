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
    @State var perfTime = 0
    @State var performance = [1, 0, 1, 1, 0, 1, 0, 0, 0.5]
    
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            withAnimation {
                if self.timeLeft > 0 {
                    self.timeLeft -= 1
                } else {
                    if self.perfTime < self.performance.count {
                        UIScreen.main.brightness = CGFloat(self.performance[self.perfTime])
                        self.perfTime += 1
                    } else {
                        self.back = true
                    }
                }
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
                            .foregroundColor(Colors.blue)
                    }.padding(.leading, 60)
                    Spacer()
                }
                HStack {
                    Text("Дата начала: ")
                        .padding()
                        .foregroundColor(Colors.blue)
                    
                    Text("\(Date(timeIntervalSince1970: TimeInterval(self.time)))")
                        .bold()
                        .padding()
                        .foregroundColor(Colors.blue)
                        .multilineTextAlignment(.center)
                }
                Text("До начала осталось:")
                    .font(.system(size: 20))
                    .padding()
                    .foregroundColor(Colors.blue)
                Text("\(timeLeft) с. ")
                    .font(.system(size: 45))
                    .bold()
                    .padding()
                    .foregroundColor(Colors.blue)
                    .onAppear(perform: {
                        _ = self.timer
                    })
                
                Spacer()
                
                Text("Поднимите телефон над головой и направьте экраном к полю")
                    .font(.system(size: 30))
                    .padding()
                    .foregroundColor(Colors.blue)
                    .multilineTextAlignment(.center)
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
        return Int(time - Int(timestamp))
    }
}
