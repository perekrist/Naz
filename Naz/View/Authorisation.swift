//
//  Home.swift
//  Naz
//
//  Created by Кристина Перегудова on 22.08.2020.
//  Copyright © 2020 Кристина Перегудова. All rights reserved.
//

import SwiftUI

struct Authorisation: View {
    @ObservedObject var networkService = Auth()
    
    @State var signUp = false
    @State var user = ""
    @State var email = ""
    @State var pass = ""
    @State var rePass = ""
    
    @State var code = ""
    
    @State var emailConfiramation = false
    
    var body: some View {
        ZStack {
            ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
                ZStack {
                    ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
                        
                        Colors.blue
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
                                .foregroundColor(Colors.blue)
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
                            
                            Button(action: {
                                self.networkService.signIn(login: self.user, password: self.pass) {
                                    print("login")
                                }
                            }) {
                                Text("Login")
                                    .fontWeight(.bold)
                                    .foregroundColor(Colors.blue)
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
                        .foregroundColor(Colors.blue)
                    
                    Text("Username")
                        .foregroundColor(Colors.blue)
                        .padding(.top,10)
                    
                    VStack {
                        TextField("Useraname", text: $user)
                        
                        Divider()
                            .background(Colors.blue.opacity(0.5))
                    }
                    Text("Email")
                        .foregroundColor(Colors.blue)
                        .padding(.top,10)
                    
                    VStack {
                        TextField("Email", text: $email)
                        
                        Divider()
                            .background(Colors.blue.opacity(0.5))
                    }
                    Text("Password")
                        .foregroundColor(Colors.blue)
                        .padding(.top,10)
                    
                    VStack {
                        SecureField("Paswword", text: $pass)
                        
                        Divider()
                            .background(Colors.blue.opacity(0.5))
                    }
                    Text("Re-Enter")
                        .foregroundColor(Colors.blue)
                        .padding(.top,10)
                    
                    VStack {
                        
                        SecureField("Re-Enter", text: $rePass)
                        
                        Divider()
                            .background(Colors.blue.opacity(0.5))
                    }
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
//                            self.networkService.signUp(login: self.user, email: self.email, password: self.pass) {
//                                print("sign up")
//                                self.emailConfiramation = true
//                            }
                            self.emailConfiramation = true
                        }) {
                            Text("Sign Up")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .padding(.horizontal,45)
                                .background(Colors.blue)
                                .clipShape(Capsule())
                        }
                        
                        Spacer()
                    }
                    .padding(.top)
                }
                .padding(.top,(UIApplication.shared.windows.first?.safeAreaInsets.top)! + 50)
                .padding()
            }
            .background(Color.white.edgesIgnoringSafeArea(.all))
            .preferredColorScheme(signUp ? .light : .dark)
            
            if emailConfiramation {
                ZStack {
                    Colors.grey.edgesIgnoringSafeArea(.all).opacity(0.5)
                    VStack {
                        VStack {
                            TextField("Code", text: $code)
                            
                            Divider()
                                .background(Color.white.opacity(0.5))
                        }
                        
                        Button(action: {
                            self.networkService.confirmEmail(code: self.code) {
                                self.emailConfiramation = false
                            }
                        }) {
                            Text("Подтвердить почту")
                                .frame(width: UIScreen.main.bounds.width - 80)
                        }.padding()
                            .background(Colors.blue)
                            .foregroundColor(Colors.yellow)
                            .cornerRadius(20)
                    }.padding()
                        .background(Color.white)
                        .cornerRadius(20)
                        .padding()
                }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Authorisation()
    }
}
