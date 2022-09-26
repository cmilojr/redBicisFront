//
//  TextAlert.swift
//  redBiciFront
//
//  Created by Camilo Jiménez on 25/09/22.
//

import SwiftUI

struct TextAlert: View {
    @Binding var isShown: Bool
    @Binding var descriptionText: String
    @Binding var colorText: String
    @Binding var didSave: Bool
    
    var title: String = "Add Bike"
    let screeSize = UIScreen.main.bounds
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title)
                .foregroundColor(.white)
            TextField("Description", text: $descriptionText)
                .textFieldStyle(.roundedBorder)
                
            TextField("Color", text: $colorText)
                .textFieldStyle(.roundedBorder)
            
            HStack {
                Button {
                    self.didSave = true
                    self.isShown = false
                } label: {
                    Text("Cancel")
                        .fontWeight(.semibold)
                        .frame(width: 70, height: 40)
                }

                Button {
                    self.isShown = false
                } label: {
                    Text("Add")
                        .frame(width: 70, height: 40)
                }
            }
        }
        .padding()
        .frame(width: screeSize.width * 0.7, height: screeSize.height * 0.23)
        .background(Color.gray.opacity(0.7))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .offset(y: isShown ? 0 : screeSize.height)
        .animation(.spring(), value: 300)
        .shadow(color: Color.black.opacity(0.3), radius: 6, x: -9, y: -9)
    }
}

struct TextAlert_Previews: PreviewProvider {
    static var previews: some View {
        TextAlert(isShown: .constant(true), descriptionText: .constant(""), colorText: .constant(""), didSave: .constant(true))
    }
}
