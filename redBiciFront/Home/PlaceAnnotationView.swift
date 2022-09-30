//
//  PlaceAnnotationView.swift
//  redBiciFront
//
//  Created by juan.jimenezr on 27/09/22.
//

import SwiftUI

struct PlaceAnnotationView: View {
    @State private var showTitle = true
    
    var bike: Bike
    let actionShowDetail: (Bike) -> Void
    
    
    var body: some View {
        VStack(spacing: 0) {
            Text(bike.description)
                .font(.callout)
                .padding(5)
                .background(Color(.white))
                .cornerRadius(10)
                .opacity(showTitle ? 0 : 1)
            
            Image(systemName: "mappin.circle.fill")
                .font(.title)
                .foregroundColor(.red)
            
            Image(systemName: "arrowtriangle.down.fill")
                .font(.caption)
                .foregroundColor(.red)
                .offset(x: 0, y: -5)
        }
        .onTapGesture {
            withAnimation(.easeInOut) {
                showTitle.toggle()
            }
        }
        .onLongPressGesture {
            withAnimation(.easeInOut) {
                self.actionShowDetail(bike)
            }
        }
    }
}
