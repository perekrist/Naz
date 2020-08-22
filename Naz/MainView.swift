//
//  MainView.swift
//  Naz
//
//  Created by Кристина Перегудова on 22.08.2020.
//  Copyright © 2020 Кристина Перегудова. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @State var event: Event = Event(name: "СОЧИ - УРАЛ", date: 2334, place: "Стадион Фишт")
    
    @State var news: [String] = ["Новый игрок"]
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.7937315106, green: 0.7840339541, blue: 0.7840581536, alpha: 1)).edgesIgnoringSafeArea(.all)
            VStack {
                VStack {
                    Text(event.name)
                        .font(.system(size: 40))
                        .bold()
                    
                    Text("\(event.date)")
                        .font(.system(size: 30))
                    
                    Text(event.place)
                        .font(.system(size: 20))
                    
                    Button(action: {
                        
                    }) {
                        Text("Купить билет")
                            .padding(15)
                            .foregroundColor(Color(#colorLiteral(red: 0.002782522002, green: 0.1660973132, blue: 0.2877466083, alpha: 1)))
                    }
                    .background(Color(#colorLiteral(red: 0.9992646575, green: 0.7418256402, blue: 0.006029339042, alpha: 1)))
                    .cornerRadius(20)
                    .padding(.top, 10)
                }.padding()
                    .frame(width: UIScreen.main.bounds.width - 30)
                    .background(Color.white)
                    .cornerRadius(20)
                
                
                ScrollView {
                    VStack {
                        Text("1")
                        Text("1")
                        Text("1")
                        Text("1")
                    }
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
