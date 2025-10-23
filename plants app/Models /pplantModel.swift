//
//  pplantModel.swift
//  plants app
//
//  Created by shahad khaled on 29/04/1447 AH.
//

import Foundation

struct Plant: Identifiable, Equatable {
    var plantID: UUID
    var plantName: String
    var selectedRoom: String
    var selectedLight: String
    var wateringDay: String
    var watering: String

    // Identifiable conformance using your stored plantID
    var id: UUID { plantID }
}

