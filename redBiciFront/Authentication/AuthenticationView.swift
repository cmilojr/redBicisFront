//
//  LogginView.swift
//  redBiciFront
//
//  Created by Camilo Jiménez on 17/09/22.
//

import SwiftUI
import GoogleSignIn
import FirebaseCore
import FirebaseAuth

struct AuthenticationView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    init() {
        if FirebaseApp.app() == nil {
               FirebaseApp.configure()
        }
    }
    
    var body: some View {
        ZStack {
            Color.cyan
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundStyle(.linearGradient(colors: [.pink], startPoint: .topLeading, endPoint: .bottomLeading))
                .frame(width: 1000,height: 400)
                .rotationEffect(.degrees(135))
                .offset(y: -400)
            VStack {
                Text("Welcome")
                    .foregroundColor(.white)
                    .font(.system(size: 70, weight: .medium, design: .rounded))
                    .offset(x: -15, y: -70)
                ZStack {
                    RoundedRectangle(cornerRadius: 30, style: .circular)
                        .foregroundColor(.white)
                        .opacity(0.9)
                        .frame(width: 310, height: 130)
                    Text("Please use your google account for Login and \nSign in")
                        .foregroundColor(.gray)
                        .lineLimit(3)
                        .font(.system(size: 25, weight: .regular, design: .rounded))
                        .frame(width: 300, height: 200)
                        
                }.offset(y: -100)
                
                Button {
                    viewModel.signIn()
                } label: {
                    ZStack {
                        Color.white
                        HStack {
                            Image(uiImage: UIImage(named: "GoogleLogo")!)
                                .resizable()
                                .frame(width: 40, height: 40, alignment: .center)
                            
                            Text("Continue with Google")
                                .fontWeight(.medium)
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                        }
                    }
                }
                .frame(width: 300, height: 70)
                .cornerRadius(50)
            }
        }
        .ignoresSafeArea()
    }
}

struct LogginView_Previews: PreviewProvider {
    
    static var previews: some View {
        AuthenticationView()
    }
}
