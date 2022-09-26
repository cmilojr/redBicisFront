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
    @StateObject var viewModel = AuthenticationViewModel()
    
    init() {
        setupAuthentication()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
              ContentView()
                    .environmentObject(viewModel)
            }
        }
    }
}

extension redBiciFrontApp {
  private func setupAuthentication() {
    FirebaseApp.configure()
  }
}
