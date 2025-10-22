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
        ID: UUID(),
        plantName: "",
        selectedRoom: "Living Room",
        selectedLight: "Full Sun",
        wateringDay: "Every Day",
        watering: "20-50 ml"
    )
    
    // Store multiple plants
    @Published var plants: [Plant] = []
    
    // CRUD helpers
    func add(_ plant: Plant) {
        plants.append(plant)
    }
    
    func remove(at offsets: IndexSet) {
        plants.remove(atOffsets: offsets)
    }
    
    func update(_ plant: Plant) {
        guard let index = plants.firstIndex(where: { $0.ID == plant.ID }) else { return }
        plants[index] = plant
    }
}
