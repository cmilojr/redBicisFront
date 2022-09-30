//
//  redBiciFrontApp.swift
//  redBiciFront
//
//  Created by Camilo Jiménez on 17/09/22.
//

import SwiftUI
import Firebase
import GoogleSignIn

@main
struct redBiciFrontApp: App {
    @ObservedObject var viewModelAuth = AuthenticationViewModel()
    init() {
        setupAuthentication()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
              ContentView()
            }.environmentObject(viewModelAuth)
        }
    }
}

extension redBiciFrontApp {
  private func setupAuthentication() {
    FirebaseApp.configure()
  }
}
