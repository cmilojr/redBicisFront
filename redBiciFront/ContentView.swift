//
//  ContentView.swift
//  redBiciFront
//
//  Created by Camilo Jiménez on 17/09/22.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        switch viewModel.state {
        case .signedIn: HomeView()
        case .signedOut: HomeView()
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
