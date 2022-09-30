//
//  HomeView.swift
//  redBiciFront
//
//  Created by Camilo Jiménez on 25/09/22.
//

import SwiftUI
import MapKit

struct HomeView: View {
    @EnvironmentObject var videModelAuth: AuthenticationViewModel
    @ObservedObject var viewModelHome: HomeViewModel = HomeViewModel()
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude:  6.20020215, longitude: -75.5784848084993), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
    @State var presentAlert: Bool = false
    @State var descriptionBike: String = ""
    @State var colorBike: String = ""
    @State var lat: Double = 0.0
    @State var long: Double = 0.0
    @State var isShowEdit: Bool = false
    @State private var bikes = [Bike]()
    @State private var bikeEdit: Bike? = nil
    
    func saveBike() {
        let latStr = String(lat)
        let longStr = String(long)
        let bike = Bike(id: UUID().uuidString, color: colorBike, description: descriptionBike, latitude: latStr, longitud: longStr)
        
        viewModelHome.saveBike(bike)
        
        colorBike = ""
        descriptionBike = ""
        lat = 0.0
        long = 0.0
    }
    
    func showDetail(bike: Bike) {
        self.descriptionBike = bike.description
        self.colorBike = bike.color
        
        self.isShowEdit = true
        self.bikeEdit = bike
    }
    
    func saveUpdateBike() {
        guard var bike = bikeEdit else { return }
        bike.color = colorBike
        bike.description = descriptionBike
        
        viewModelHome.saveBike(bike)
        
        colorBike = ""
        descriptionBike = ""
        lat = 0.0
        long = 0.0
    }
    
    func actionDelete() {
        guard let bike = bikeEdit else { return }
        viewModelHome.deleteBike(bike)
        
        colorBike = ""
        descriptionBike = ""
        lat = 0.0
        long = 0.0

    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Map(coordinateRegion: $mapRegion, annotationItems: viewModelHome.bikes) { bike in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: Double(bike.latitude)!, longitude: Double(bike.longitud)!)) {
                        PlaceAnnotationView(bike: bike, actionShowDetail: showDetail)
                    }
                }
                    .ignoresSafeArea()
                
                Circle()
                    .fill(.blue)
                    .opacity(0.3)
                    .frame(width: 32, height: 32)
                
                HStack {
                    Button {
                        videModelAuth.signOut()
                    } label: {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(.red.opacity(0.75))
                    .font(.title)
                    .clipShape(Circle())
                    .padding(.trailing)

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
                }.offset(y: 280)
                TextAlert(isShown: $presentAlert, descriptionText: $descriptionBike, colorText: $colorBike, actionAdd: saveBike)
                EditAlert(isShown: $isShowEdit, descriptionText: $descriptionBike, colorText: $colorBike, actionSave: saveUpdateBike, actionDelete: actionDelete)
            }
            .onAppear {
                viewModelHome.fetchBikes()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


