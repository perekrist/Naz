//
//  MainView.swift
//  Naz
//
//  Created by Кристина Перегудова on 22.08.2020.
//  Copyright © 2020 Кристина Перегудова. All rights reserved.
//

import SwiftUI
import SVProgressHUD

struct MainView: View {
    @State var performances: [Performance] = []
    @Binding var buyTicket: Bool
    @ObservedObject var networkService = NetworkService()
    @ObservedObject var perfomarmance = Perfomarmance()
    
    var body: some View {
        ZStack {
            Colors.grey.edgesIgnoringSafeArea(.all)
            VStack {
                VStack {
                    Text(networkService.events[0].name)
                        .font(.system(size: 40))
                        .bold()
                        .foregroundColor(Colors.blue)
                    
                    Text("\(Date(timeIntervalSince1970: TimeInterval(networkService.events[0].date)))")
                        .font(.system(size: 20))
                    
                    Text(networkService.events[0].place)
                        .font(.system(size: 20))
                    
                    Button(action: {
                        self.buyTicket.toggle()
                    }) {
                        Text("Купить билет")
                            .padding(15)
                            .foregroundColor(Colors.blue)
                    }
                    .frame(width: UIScreen.main.bounds.width - 60)
                    .background(Colors.yellow)
                    .cornerRadius(15)
                    .padding(.top, 10)
                }.padding()
                    .frame(width: UIScreen.main.bounds.width - 30)
                    .background(Color.white)
                    .cornerRadius(20)
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            SVProgressHUD.show()
                            if self.perfomarmance.performances.count == 0 {
                                self.perfomarmance.getPerformances {
                                    self.performances = self.perfomarmance.performances
                                    SVProgressHUD.dismiss()
                                }
                            } else {
                                self.performances = self.perfomarmance.performances
                                SVProgressHUD.dismiss()
                            }
                        }) {
                            Image(systemName: "arrow.2.circlepath")
                                .padding()
                                .foregroundColor(Colors.blue)
                                .font(.system(size: 40))
                        }
                    }
                    if self.performances.count == 0 {
                        VStack {
                            Text("Список инициатив пуст.")
                                .foregroundColor(Colors.darkGrey)
                                .font(.system(size: 30))
                            
                            Text("Вы можете создать инициативу на странице создания инициатив.")
                                .foregroundColor(Colors.darkGrey)
                            
                        }
                    } else {
                        ForEach(self.performances, id: \.self) { perf in
                            HStack {
                                Text(perf.action)
                                    .padding()
                                    .foregroundColor(Colors.blue)
                                Text("\(Date(timeIntervalSince1970: TimeInterval(perf.timestamp)))")
                                    .padding()
                                    .foregroundColor(Colors.blue)
                            }.background(Color.white)
                                .cornerRadius(20)
                                .padding()
                        }
                    }
                    Spacer()
                }
            }
            
        }
    }
}
