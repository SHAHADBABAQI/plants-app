//
//  pplantModel.swift
//  plants app
//
//  Created by shahad khaled on 29/04/1447 AH.
//

import Foundation

struct Plant: Identifiable, Equatable, Codable {
    var plantID: UUID
    var plantName: String
    var selectedRoom: String
    var selectedLight: String
    var wateringDay: String
    var watering: String
    // Anchor date for the watering schedule. We update this when the user waters the plant.
    var lastWateredDate: Date = Date()

    // Identifiable conformance using your stored plantID
    var id: UUID { plantID }
}

