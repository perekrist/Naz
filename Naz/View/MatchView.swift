//
//  MatchView.swift
//  Naz
//
//  Created by Кристина Перегудова on 22.08.2020.
//  Copyright © 2020 Кристина Перегудова. All rights reserved.
//

import SwiftUI

struct MatchView: View {
    @State var sectors: [Sector] = [Sector(name: "Сектор А101", cost: 1300, freePlaces: 125), Sector(name: "Сектор А102", cost: 1400, freePlaces: 105), Sector(name: "Сектор А103", cost: 300, freePlaces: 5)]
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Секторы")
                    .bold()
                    .frame(width: UIScreen.main.bounds.width/3)
                Spacer()
                Text("Стоимость")
                    .bold()
                    .frame(width: UIScreen.main.bounds.width/3)
                Spacer()
                Text("Свободные места")
                    .bold()
                    .frame(width: UIScreen.main.bounds.width/3)
                Spacer()
            }.padding()
                .frame(width: UIScreen.main.bounds.width)
                .background(Colors.blue.edgesIgnoringSafeArea(.top))
                .foregroundColor(.white)
            
            ScrollView {
                ForEach(sectors, id: \.self) { sector in
                    VStack {
                        HStack {
                            Spacer()
                            Text(sector.name)
                                .frame(width: UIScreen.main.bounds.width/3)
                            Spacer()
                            Text("\(sector.cost)")
                                .frame(width: UIScreen.main.bounds.width/3)
                            Spacer()
                            Text("\(sector.freePlaces)")
                                .frame(width: UIScreen.main.bounds.width/3)
                            Spacer()
                        }.padding()
                        Divider()
                    }
                }
            }
        }
    }
}

struct MatchView_Previews: PreviewProvider {
    static var previews: some View {
        MatchView()
    }
}
