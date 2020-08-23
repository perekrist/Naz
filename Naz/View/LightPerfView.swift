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
                self.perfTime = self.getPerfTime()
                print(self.perfTime)
                if self.timeLeft > 0 {
                    self.timeLeft -= 1
                } else {
                    print("else1")
                    if self.perfTime < self.performance.count && self.perfTime > 0 {
                        UIScreen.main.brightness = CGFloat(self.performance[self.perfTime])
                        self.perfTime += 1
                    } else {
                        print("else2")
                        if self.perfTime > self.performance.count {
                            if -self.perfTime < self.performance.count {
                                if self.perfTime < self.performance.count {
                                    print(self.perfTime)
                                    UIScreen.main.brightness = CGFloat(self.performance[self.perfTime])
                                    self.perfTime -= 1
                                }
                            } else {
                                print("else3")
                                self.back = true
                                self.timer.invalidate()
                            }
                        } else {
                            print("else4")
                            self.back = true
                            self.timer.invalidate()
                        }
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
                        self.timer.invalidate()
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
                if timeLeft > 0 {
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
                }
                
                if perfTime > 0 {
                    Text("Инициатива идет уже")
                        .font(.system(size: 20))
                        .padding()
                        .foregroundColor(Colors.blue)
                    
                    Text("\(perfTime) с. ")
                        .font(.system(size: 45))
                        .bold()
                        .padding()
                        .foregroundColor(Colors.blue)
                        .onAppear(perform: {
                            _ = self.timer
                        })
                }
                
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
            self.perfTime = self.getPerfTime()
        }
        .navigate(to: BottomMenu(), when: $back)
    }
    
    func getRemTime() -> Int {
        let timestamp = NSDate().timeIntervalSince1970
        return Int(time - Int(timestamp))
    }
    
    func getPerfTime() -> Int {
        let timestamp = NSDate().timeIntervalSince1970
        return Int(Int(timestamp) - time)
    }
}
