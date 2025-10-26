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
        watering: "20-50 ml",
//        isChecked: false

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
    
    // Convenience removal for places where we have a specific plant/id (e.g., EditSheet)
    func remove(id: UUID) {
        if let index = plants.firstIndex(where: { $0.plantID == id }) {
            plants.remove(at: index)
        }
    }
    
    func remove(_ plant: Plant) {
        remove(id: plant.plantID)
    }
    
    func update(_ plant: Plant) {
        guard let index = plants.firstIndex(where: { $0.plantID == plant.plantID }) else { return }
        plants[index] = plant
    }
    

}

