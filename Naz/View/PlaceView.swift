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
                    Text("Доступные места в секторе " + sector)
                        .bold()
                        .padding()
                        .font(.system(size: 30))
                        .foregroundColor(Colors.blue)
                    
                    Spacer()
                    
                    Button(action: {
                        self.networkService.getPlaces(event_id: 90, sector_id: self.id, completion: {
                            print(self.networkService.places)
                            self.places = self.networkService.places
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
                        
                        Text("Место \(place.place)")
                    }.onTapGesture {
                        print(place.place)
                    }
                }
            }
        }
    }
}
