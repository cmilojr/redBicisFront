//
//  ContentView.swift
//  redBiciFront
//
//  Created by Camilo Jiménez on 17/09/22.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @EnvironmentObject var viewModelAuth: AuthenticationViewModel
    var body: some View {
        switch viewModelAuth.state {
        case .signedIn:
            HomeView()
                .environmentObject(viewModelAuth)
        case .signedOut:
            AuthenticationView()
                .environmentObject(viewModelAuth)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
