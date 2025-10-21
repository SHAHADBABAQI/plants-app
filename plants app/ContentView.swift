//
//  ContentView.swift
//  plants app
//
//  Created by shahad khaled on 24/04/1447 AH.
//
import SwiftUI

struct ContentView: View {
    @State private var setReminder = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Header Section
            VStack(alignment: .leading, spacing: 15) {
                Text("My Plants 🌱")
                    .font(.system(size: 34, design: .default))
                    .bold()
                Rectangle()
                    .frame(height: 0.3)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)
            .padding(.top)
            
            Spacer()
            
            // Middle Content Section
            VStack(spacing: 30) {
                Image("plantChar")
                
                Text("Start your plant journey!")
                    .bold()
                    .font(.system(size: 25, design: .default))
                
                Text("Now all your plants will be in one place and we will help you take care of them :)🪴")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                    .font(.system(size: 16, design: .default))
                    .padding(.horizontal)
            }
            
            Spacer()
            
            // Button Section
            Button("Set Plant Reminder") {
                setReminder.toggle()
            }
            .frame(width: 280, height: 18)
            .padding()
            .background(Color.button)
            .cornerRadius(60)
            .buttonStyle(.plain)
            .glassEffect(.clear)
            .sheet(isPresented: $setReminder) {
                ReminderSheet()
            }
            .padding(.bottom, 40)
            Spacer()
        }
        Spacer()
    }
}

#Preview {
    ContentView()
}
