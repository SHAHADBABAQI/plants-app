//
//  notification.swift
//  plants app
//
//  Created by shahad khaled on 04/05/1447 AH.
//
import Foundation
import UserNotifications

class NotificationManager {
    
    static let shared = NotificationManager()
    private init() {}
    
    // Ask for permission
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification permission granted ✅")
            } else {
                print("Notification permission denied ❌")
            }
        }
    }
    
    // Map the user's "wateringDay" selection to an integer interval (in days).
    // Mirrors PlantViewModel.intervalDays(for:)
    private func intervalDays(for wateringDay: String) -> Int {
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
    
    // Schedule repeating watering reminder
    func scheduleWateringReminder(for plant: Plant) {
        let content = UNMutableNotificationContent()
        content.title = "Planto"
        content.body = "Your \(plant.plantName) needs watering."
        content.sound = .default
        
//         let days = intervalDays(for: plant.wateringDay)
//         let interval = TimeInterval(days * 24 * 60 * 60)
        let interval: TimeInterval = 60
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: true)
        
        let request = UNNotificationRequest(
            identifier: plant.id.uuidString,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            } else {
                print("Notification scheduled for \(plant.plantName) ✅")
            }
        }
    }
    
    // Cancel notification when plant gets deleted
    func cancelReminder(for plant: Plant) {
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(withIdentifiers: [plant.id.uuidString])
    }
}
