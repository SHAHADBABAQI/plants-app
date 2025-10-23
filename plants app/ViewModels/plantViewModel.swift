//
//  plantViewModel.swift
//  plants app
//
//  Created by shahad khaled on 30/04/1447 AH.
//

import SwiftUI
internal import Combine

class PlantViewModel: ObservableObject {
    // Single plant for editing/adding flows
    @Published var plant: Plant = Plant(
        plantID: UUID(),
        plantName: "",
        selectedRoom: "Living Room",
        selectedLight: "Full Sun",
        wateringDay: "Every Day",
        watering: "20-50 ml"
    )
    
    // Store multiple plants
    @Published var plants: [Plant] = []
    
    // Navigation trigger to go to checkView after adding from a sheet
    @Published var navigateToCheckViewAfterAdd: Bool = false
    
    // CRUD helpers
    func add(_ plant: Plant) {
        plants.append(plant)
    }
    
    func remove(at offsets: IndexSet) {
        plants.remove(atOffsets: offsets)
    }
    
    func update(_ plant: Plant) {
        guard let index = plants.firstIndex(where: { $0.plantID == plant.plantID }) else { return }
        plants[index] = plant
    }
}



//import Foundation
//
//class PlantViewModel: ObservableObject {
//    @Published var plants: [Plant] = [
//        Plant(plantName: "", selectedRoom: "", selectedLight: "", wateringDay: "", watering: "")
//    ]
//
//    func addPlant(name: String, flour: Double, sugar: Double, eggs: Int) {
//        let newPlant = Plant(plantName: , selectedRoom: , selectedLight: , wateringDay: , watering: )
//        plants.append(newPlant)
//    }
//
//    func removePlant(at offsets: IndexSet) {
//        plants.remove(atOffsets: offsets)
//    }
//}
//
