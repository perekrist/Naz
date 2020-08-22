//
//  BottomMenu.swift
//  Naz
//
//  Created by Кристина Перегудова on 22.08.2020.
//  Copyright © 2020 Кристина Перегудова. All rights reserved.
//

import SwiftUI

struct BottomMenu: View {
    @State var index = 0
    @State var buyTicket = false
    
    var body: some View {
        VStack(spacing: 0) {
            
            ZStack {
                
                MainView(buyTicket: $buyTicket)
                    .opacity(self.index == 0 ? 1 : 0)
                
                Text("Account")
                    .opacity(self.index == 1 ? 1 : 0)
            }
            
            HStack {
                Button(action: {
                    self.index = 0
                    
                }) {
                    HStack(spacing: 6) {
                        
                        Image(systemName: "list.bullet.indent")
                            .foregroundColor(self.index == 0 ? Colors.blue : .primary)
                        
                        if self.index == 0 {
                            Text("Feed")
                                .foregroundColor(Colors.blue)
                        }
                        
                    }
                    .padding(.vertical,10)
                    .padding(.horizontal)
                    .background(self.index == 0 ? Colors.yellow : Color.clear)
                    .clipShape(Capsule())
                }
                
                Spacer(minLength: 0)
                Button(action: {
                    self.index = 1
                    
                }) {
                    HStack(spacing: 6) {
                        Image(systemName: "person")
                            .foregroundColor(self.index == 1 ? Colors.blue : .primary)
                        
                        if self.index == 1 {
                            Text("Account")
                                .foregroundColor(Colors.blue)
                        }
                        
                    }
                    .padding(.vertical,10)
                    .padding(.horizontal)
                    .background(self.index == 1 ? Colors.yellow : Color.clear)
                    .clipShape(Capsule())
                }
            }
            .padding(.horizontal,25)
            .padding(.top)
                .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 10 : UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                .shadow(color: Color.primary.opacity(0.08), radius: 5, x: 5, y: -5)
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigate(to: MatchView(), when: $buyTicket)
    }
}

struct BottomMenu_Previews: PreviewProvider {
    static var previews: some View {
        BottomMenu()
    }
}
