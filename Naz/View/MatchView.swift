//
//  MatchView.swift
//  Naz
//
//  Created by Кристина Перегудова on 22.08.2020.
//  Copyright © 2020 Кристина Перегудова. All rights reserved.
//

import SwiftUI
import SVProgressHUD

struct MatchView: View {
    @ObservedObject var networkService = Sectors()
    @State var back = false
    @State var id = 0
    @State var sector = ""
    
    @State var show = false
    
    @State private var isShowing = false
    
    var body: some View {
        VStack {
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
                    .foregroundColor(.white)
            }.background(Colors.blue.edgesIgnoringSafeArea(.top))
            
            ScrollView {
                ForEach(self.networkService.sectors, id: \.self) { sector in
                    VStack {
                        HStack {
                            Spacer()
                            Text(sector.name)
                                .frame(width: UIScreen.main.bounds.width*(3/8))
                            Spacer()
                            Text("\(Int(sector.cost))")
                                .frame(width: UIScreen.main.bounds.width*(3/8))
                            Spacer()
                            Text("\(sector.freePlaces)")
                                .frame(width: UIScreen.main.bounds.width/4)
                            Spacer()
                        }.padding()
                        Divider()
                    }
                    .onTapGesture {
                        self.id = sector.id
                        self.sector = sector.name
                        self.show.toggle()
                    }.sheet(isPresented: self.$show) {
                        PlaceView(sector_id: self.id, sector: self.sector)
                    }
                }
            }
        }
        .navigate(to: BottomMenu(), when: $back)
        
    }
}

struct MatchView_Previews: PreviewProvider {
    static var previews: some View {
        MatchView()
    }
}
