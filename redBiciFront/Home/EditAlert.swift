//
//  EditAlert.swift
//  redBiciFront
//
//  Created by juan.jimenezr on 29/09/22.
//

import SwiftUI

struct EditAlert: View {
    @Binding var isShown: Bool
    @Binding var descriptionText: String
    @Binding var colorText: String
    
    let actionSave: () -> Void
    let actionDelete: () -> Void
    var title: String = "Edit Bike"
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
                    self.isShown = false
                } label: {
                    Text("Cancel")
                        .frame(width: 70, height: 40)
                }

                Button {
                    self.isShown = false
                    self.actionSave()
                } label: {
                    Text("Save")
                        .fontWeight(.semibold)
                        .frame(width: 70, height: 40)
                }
                
                Button {
                    self.isShown = false
                    self.actionDelete()
                } label: {
                    Text("Delete")
                        .fontWeight(.semibold)
                        .frame(width: 70, height: 40)
                        .foregroundColor(.red)
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

struct EditAlert_Previews: PreviewProvider {
    static var previews: some View {
        EditAlert(isShown: .constant(true), descriptionText: .constant(""), colorText: .constant(""), actionSave: {}, actionDelete: {})
    }
}

