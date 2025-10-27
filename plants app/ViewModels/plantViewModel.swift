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
    @Published var plants: [Plant] = [] {
        didSet { savePlants() }
    }
    
    // Navigation trigger to go to checkView after adding from a sheet
    @Published var navigateToCheckViewAfterAdd: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private let storageKey = "plants.storage.v1"
    
    init() {
        loadPlants()
        // Optional: ensure any future direct mutations still save
        $plants
            .sink { [weak self] _ in
                self?.savePlants()
            }
            .store(in: &cancellables)
    }
    
    // MARK: - CRUD helpers
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
    
    // MARK: - Scheduling
    
    // Map the user's "wateringDay" selection to an integer interval (in days).
    func intervalDays(for wateringDay: String) -> Int {
        switch wateringDay {
        case "Every Day":
            return 1
        case "Every 2 Days":
            return 2
        case "Every 3 Days":
            return 3
        case "Once a week":
            return 7
        case "Every 10 Days":
            return 10
        case "Every 2 weeks":
            return 14
        default:
            return 3 // safe fallback
        }
    }
    
    // Determine if a plant is due today (or overdue).
    func isDue(_ plant: Plant, on date: Date = Date()) -> Bool {
        let days = intervalDays(for: plant.wateringDay)
        guard let nextDue = Calendar.current.date(byAdding: .day, value: days, to: plant.lastWateredDate) else {
            return false
        }
        // Due if nextDue is today or in the past
        return nextDue <= date
    }
    
    // Computed list of plants that are due today (or overdue)
    var plantsDueToday: [Plant] {
        plants.filter { isDue($0) }
    }
    
    // Mark a plant as watered: set lastWateredDate to now and update array
    func markWatered(_ plant: Plant) {
        guard let index = plants.firstIndex(where: { $0.plantID == plant.plantID }) else { return }
        var updated = plants[index]
        updated.lastWateredDate = Date()
        plants[index] = updated
    }
    
    // MARK: - UI helpers
    
    // Map selected light to the asset name used by Image(...)
    func lightIconName(for selectedLight: String) -> String {
        switch selectedLight {
        case "Full Sun":
            return "sun"
        case "Partial Sun":
            return "sun.haze"
        case "Low Light":
            return "moon"
        default:
            return "sun"
        }
    }
    
    // MARK: - Persistence (UserDefaults + JSON)
    private func savePlants() {
        do {
            let data = try JSONEncoder().encode(plants)
            UserDefaults.standard.set(data, forKey: storageKey)
        } catch {
            print("Failed to encode plants: \(error)")
        }
    }
    
    private func loadPlants() {
        guard let data = UserDefaults.standard.data(forKey: storageKey) else { return }
        do {
            let decoded = try JSONDecoder().decode([Plant].self, from: data)
            plants = decoded
        } catch {
            print("Failed to decode plants: \(error)")
        }
    }
}

