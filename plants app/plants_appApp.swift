//
//  plants_appApp.swift
//  plants app
//
//  Created by shahad khaled on 24/04/1447 AH.
//

import SwiftUI

@main
struct plants_appApp: App {
    // Provide a single shared instance for the whole app
    @StateObject private var viewModel = PlantViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
