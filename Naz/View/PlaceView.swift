//
//  PlaceView.swift
//  Naz
//
//  Created by Кристина Перегудова on 22.08.2020.
//  Copyright © 2020 Кристина Перегудова. All rights reserved.
//

import SwiftUI

struct PlaceView: View {
    @State var id: Int
    @ObservedObject var networkService = NetworkService()
    @State var sector: String
    
    var body: some View {
        ZStack {
            Colors.grey.edgesIgnoringSafeArea(.all)
            VStack {
                Text("Доступные места в секторе " + sector)
                    .bold()
                    .padding()
                    .font(.system(size: 30))
                    .foregroundColor(Colors.blue)
                ScrollView {
                    ForEach(self.networkService.places, id: \.self) { place in
                        VStack {
                            Text("Ряд \(place.row) Место \(place.place)")
                            Divider()
                        }
                    }
                }
            }.onAppear {
                self.networkService.getPlaces(event_id: 90, sector_id: self.id)
            }
        }
    }
}
