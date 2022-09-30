//
//  BikeModel.swift
//  redBiciFront
//
//  Created by Camilo Jiménez on 25/09/22.
//

import Foundation

struct Bike: Identifiable, Equatable, Codable {
    var id: String
    var color: String
    var description: String
    var latitude: String
    var longitud: String
}


struct User: Codable {
    var userId: String
    var bikes: [Bike]
}


struct DeleteModel: Codable {
    var userId: String
    var idBike: String
}
