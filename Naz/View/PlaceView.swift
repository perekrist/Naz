//
//  PlaceView.swift
//  Naz
//
//  Created by Кристина Перегудова on 22.08.2020.
//  Copyright © 2020 Кристина Перегудова. All rights reserved.
//

import SwiftUI
import SVProgressHUD

struct PlaceView: View {
    @State var id: Int
    @ObservedObject var networkService = Places()
    @State var sector: String
    @State private var isShowing = false
    
    @State var places: [Place] = []
    
    var body: some View {
        ZStack {
            Colors.grey.edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Text("Доступные места в " + sector)
                        .bold()
                        .padding()
                        .font(.system(size: 30))
                        .foregroundColor(Colors.blue)
                    
                    Spacer()
                    
                    Button(action: {
                        SVProgressHUD.setOffsetFromCenter(UIOffset(horizontal: UIScreen.main.bounds.width/2, vertical: UIScreen.main.bounds.height/2))
                        SVProgressHUD.show()
                        self.networkService.getPlaces(event_id: 90, sector_id: self.id, completion: {
                            self.places = self.networkService.places
                            SVProgressHUD.dismiss()
                        })
                    }, label: {
                        Image(systemName: "arrow.2.circlepath")
                            .padding()
                            .foregroundColor(Colors.blue)
                            .font(.system(size: 40))
                    })
                }
                
                List(self.places, id: \.self) { place in
                    HStack {
                        Text("Ряд \(place.row)")
                            .padding()
                        Text("Место \(place.place)")
                            .padding()
                        Spacer()
                        Button(action: {
                            print(place.place)
                        }) {
                            Text("Купить")
                                .foregroundColor(Colors.blue)
                        }.padding()
                            .background(Colors.yellow)
                            .cornerRadius(20)
                            .padding()
                    }
                }
            }
        }
    }
}
