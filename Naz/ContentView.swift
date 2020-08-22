//
//  ContentView.swift
//  Naz
//
//  Created by Кристина Перегудова on 22.08.2020.
//  Copyright © 2020 Кристина Перегудова. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var isLogIned = UserDefaults.standard.value(forKey: "isLogIned") as? Bool ?? false
    
    var body: some View {
        VStack {
            if !isLogIned {
                Authorisation()
                    .edgesIgnoringSafeArea(.all)
                    .statusBar(hidden: true)
            }
            
            if isLogIned {
                MainView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
