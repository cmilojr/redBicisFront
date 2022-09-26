//
//  BikeModel.swift
//  redBiciFront
//
//  Created by Camilo Jiménez on 25/09/22.
//

import Foundation

struct Bike: Identifiable, Equatable, Codable {
    var id: UUID
    var color: String
    var description: String
    var latitude: String
    var longitude: String
}
