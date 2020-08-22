//
//  Home.swift
//  Naz
//
//  Created by Кристина Перегудова on 22.08.2020.
//  Copyright © 2020 Кристина Перегудова. All rights reserved.
//

import SwiftUI

struct Home: View {
    @ObservedObject var networkService = NetworkService()
    
    @State var signUp = false
    @State var user = ""
    @State var email = ""
    @State var pass = ""
    @State var rePass = ""
    
    @State var colorMain = Color(#colorLiteral(red: 0.002782522002, green: 0.1660973132, blue: 0.2877466083, alpha: 1))
    
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .top)){
            ZStack {
                ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
                    
                    colorMain
                        .clipShape(CShape())
                    
                    Path { path in
                                                
                        path.addArc(center: CGPoint(x: UIScreen.main.bounds.width - 120 , y: UIScreen.main.bounds.height - 50), radius: 40, startAngle: .zero, endAngle: .init(degrees: 180), clockwise: true)
                    }
                    .fill(Color.white)
                                        
                    Button(action: {
                        withAnimation(.easeIn) {
                            self.signUp = false
                        }
                    }) {
                        Image(systemName: signUp ? "xmark" : "person.fill")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(colorMain)
                    }
                    .offset(x: -110, y: -50)
                        .disabled(signUp ? false : true)
                    
                    Button(action: {
                        withAnimation(.easeOut){
                            self.signUp = true
                        }
                    }) {
                        Image(systemName: signUp ? "person.badge.plus.fill" : "xmark")
                            .font(.system(size: signUp ? 26 : 25, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .offset(x: -30, y: -40)
                    .disabled(signUp ? true : false)
                }
                
                VStack(alignment: .leading, spacing: 25) {
                    Text("Login")
                        .font(.system(size: 35, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("Username")
                        .foregroundColor(.white)
                        .padding(.top,10)
                    
                    VStack {
                        TextField("Useraname", text: $user)
                        
                        Divider()
                            .background(Color.white.opacity(0.5))
                    }
                    
                    Text("Password")
                        .foregroundColor(.white)
                        .padding(.top,10)
                    
                    VStack {
                        SecureField("Paswword", text: $pass)
                        
                        Divider()
                            .background(Color.white.opacity(0.5))
                    }
                    
                    HStack {
                        Spacer()
                                                
                        Button(action: {}) {
                            Text("Login")
                                .fontWeight(.bold)
                                .foregroundColor(colorMain)
                                .padding(.vertical)
                                .padding(.horizontal,45)
                                .background(Color.white)
                                .clipShape(Capsule())
                        }
                        Spacer()
                    }
                    .padding(.top)
                    
                    Spacer(minLength: 0)
                }
                .padding(.top,(UIApplication.shared.windows.first?.safeAreaInsets.top)! + 25)
                .padding()
                
            }
            .offset(y: signUp ? -UIScreen.main.bounds.height + (UIScreen.main.bounds.height < 750 ? 100 : 130) : 0)
            .zIndex(1)
            
            //Sign UP
            
            VStack(alignment: .leading, spacing: 25) {
                Text("Sign Up")
                    .font(.system(size: 35, weight: .bold))
                    .foregroundColor(colorMain)
                
                Text("Username")
                    .foregroundColor(colorMain)
                    .padding(.top,10)
                
                VStack {
                    TextField("Useraname", text: $user)
                    
                    Divider()
                        .background(colorMain.opacity(0.5))
                }
                Text("Email")
                    .foregroundColor(colorMain)
                    .padding(.top,10)
                
                VStack {
                    TextField("Email", text: $email)
                    
                    Divider()
                        .background(colorMain.opacity(0.5))
                }
                Text("Password")
                    .foregroundColor(colorMain)
                    .padding(.top,10)
                
                VStack {
                    SecureField("Paswword", text: $pass)
                    
                    Divider()
                        .background(colorMain.opacity(0.5))
                }
                Text("Re-Enter")
                    .foregroundColor(colorMain)
                    .padding(.top,10)
                                
                VStack {
                    
                    SecureField("Re-Enter", text: $rePass)
                    
                    Divider()
                        .background(colorMain.opacity(0.5))
                }
                
                HStack {
                    Spacer()
                                        
                    Button(action: {
                        self.networkService.signUp(login: self.user, email: self.email, password: self.pass) {
                            print("hello")
                        }
                    }) {
                        Text("Sign Up")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .padding(.horizontal,45)
                            .background(colorMain)
                            .clipShape(Capsule())
                    }
                    
                    Spacer()
                }
                .padding(.top)
                
//                Spacer(minLength: 0)
            }
            .padding(.top,(UIApplication.shared.windows.first?.safeAreaInsets.top)! + 50)
            .padding()
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
            .preferredColorScheme(signUp ? .light : .dark)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
