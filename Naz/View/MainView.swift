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
            Colors.grey.edgesIgnoringSafeArea(.all)
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
                            .foregroundColor(Colors.blue)
                    }
                    .background(Colors.yellow)
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
