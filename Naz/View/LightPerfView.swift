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
    
    var body: some View {
        ZStack {
            Colors.grey.edgesIgnoringSafeArea(.all)
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
                Text("\(Date(timeIntervalSince1970: TimeInterval(self.time)))")
                    .padding()
                    .foregroundColor(Colors.blue)
                
                Spacer()
            }
        }.navigate(to: BottomMenu(), when: $back)
    }
}
