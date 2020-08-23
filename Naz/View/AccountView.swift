//
//  AccountView.swift
//  Naz
//
//  Created by Кристина Перегудова on 22.08.2020.
//  Copyright © 2020 Кристина Перегудова. All rights reserved.
//

import SwiftUI
import SVProgressHUD

struct AccountView: View {
    @ObservedObject var networkService = Profile()
    @State var login = ""
    @State var email = ""
    @State var places:[Place] = []
    
    var body: some View {
        ZStack {
            Colors.grey.edgesIgnoringSafeArea(.all)
            //            Button(action: {
            //
            //                UIScreen.main.brightness = CGFloat(1)
            //            }) {
            //                Text("Change br")
            //            }
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        SVProgressHUD.show()
                        if self.networkService.places.count == 0 {
                            self.networkService.whoAmI {
                                self.login = self.networkService.login
                                self.email = self.networkService.email
                                self.places = self.networkService.places
                                self.places = self.networkService.places
                                SVProgressHUD.dismiss()
                            }
                        } else {
                            self.login = self.networkService.login
                            self.email = self.networkService.email
                            self.places = self.networkService.places
                            self.places = self.networkService.places
                            SVProgressHUD.dismiss()
                        }
                    }) {
                        Image(systemName: "arrow.2.circlepath")
                            .padding()
                            .foregroundColor(Colors.blue)
                            .font(.system(size: 40))
                    }
                }
                Text(self.login)
                    .font(.system(size: 50))
                    .foregroundColor(Colors.blue)
                    .bold()
                Text(self.email)
                    .font(.system(size: 30))
                    .foregroundColor(Colors.blue)
                
                VStack {
                    Text("Матч СОЧИ - УРАЛ")
                        .bold()
                        .padding()
                        .font(.system(size: 20))
                        .foregroundColor(Colors.blue)
                        .cornerRadius(20)
                        .padding()
                    
                    
                    ForEach(self.places, id: \.self) { place in
                        HStack {
                            Text("Сектор \(place.sector!)")
                                .foregroundColor(Colors.blue)
                                .padding()
                            Spacer()
                            Text("Ряд \(place.row)")
                                .foregroundColor(Colors.blue)
                                .padding()
                            Text("Место \(place.place)")
                                .foregroundColor(Colors.blue)
                                .padding()
                        }
                    }
                }.padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding()
                
                Spacer()
            }.onAppear {
                self.login = self.networkService.login
                self.email = self.networkService.email
                self.places = self.networkService.places
            }
            
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
