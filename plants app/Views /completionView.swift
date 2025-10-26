//
//  completionView.swift
//  plants app
//
//  Created by shahad khaled on 29/04/1447 AH.
//



//
//  ContentView.swift
//  plants app
//
//  Created by shahad khaled on 24/04/1447 AH.
//
import SwiftUI

struct completionView: View {
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
            VStack(spacing: 45) {
                Image("plantWink")
                VStack(spacing: 20){
                    Text("All Done! 🎉")
                        .bold()
                        .font(.system(size: 25, design: .default))
                    
                    Text("All Reminders Completed")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                        .font(.system(size: 16, design: .default))
                        .padding(.horizontal)
                }
            }
            
            Spacer()
            
            // Bottom-right floating button
            HStack {
                Spacer()
                Button {
                    setReminder.toggle()
                } label: {
                    Image("plus")
                        .frame(width: 48, height: 48)
                        .background(Color.button)
                        .cornerRadius(60)
                        .glassEffect(.clear)
                }
               
            }
            .padding(.trailing, 25)
            .padding(.bottom, 20)
            .sheet(isPresented: $setReminder) {
                ReminderSheet()
            }
        }
        Spacer()
    }
    
    
    
    
    
    
    
}

#Preview {
    completionView()
}
