//
//  HomeView.swift
//  redBiciFront
//
//  Created by Camilo Jiménez on 25/09/22.
//

import SwiftUI
import MapKit

struct HomeView: View {
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude:  6.20020215, longitude: -75.5784848084993), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
    @State var presentAlert: Bool = false
    @State var descriptionBike: String = ""
    @State var colorBike: String = ""
    @State var lat: Double = 0.0
    @State var long: Double = 0.0
    @State var didSave: Bool = false {
        didSet {
            if didSave {
                saveBike()
            }
        }
    }
    @State private var bikes = [Bike]()
    func saveBike() {
        let latStr = String(lat)
        let longStr = String(long)
        let bike = Bike(id: UUID(), color: colorBike, description: descriptionBike, latitude: latStr, longitude: longStr)
        print(bike)
    }
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $mapRegion, annotationItems: bikes) { bike in
                MapMarker(coordinate: CLLocationCoordinate2D(latitude: Double(bike.latitude)!, longitude: Double(bike.longitude)!))
            }
                .ignoresSafeArea()
            
            Circle()
                .fill(.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
            
            VStack {
                Spacer()
                Button {
                    self.lat = mapRegion.center.latitude
                    self.long = mapRegion.center.longitude
                    
                    self.presentAlert = true
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                }
                .padding()
                .background(.black.opacity(0.75))
                .font(.title)
                .clipShape(Circle())
                .padding(.trailing)
                
            }
            TextAlert(isShown: $presentAlert, descriptionText: $descriptionBike, colorText: $colorBike, didSave: $didSave)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
