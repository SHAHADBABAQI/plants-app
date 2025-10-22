//
//  EditSheet.swift
//  plants app
//
//  Created by shahad khaled on 28/04/1447 AH.
//
//
//  ReminderSheet.swift
//  plants app
//
//  Created by shahad khaled on 27/04/1447 AH.
//

import SwiftUI

struct EditSheet: View {
    @Environment(\.dismiss) var dismiss
    @State private var plantName = ""
    @State private var selectedRoom = "Living Room"
    @State private var selectedLight = "Full Sun"
    @State private var wateringDay = "Every Day"
    @State private var watering = "20-50 ml"

    
    
    let rooms = ["Living Room", "Bedroom", "Kitchen", "Bathroom", "Balcony"]
    let lightOptions = ["Full Sun", "Partial Sun", "Low Light"]
    let wateringDayOptions = ["Every Day", "Every 2 Days", "Every 3 Days", "Once a week", "Every 10 Days", "Every 2 weeks"]
    let wateringOptions = ["20-50 ml", "50-100 ml", "100-200 ml", "200-300 ml"]

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image("close")
                        .frame(width: 48, height: 48)
                        .cornerRadius(60)
                        .glassEffect(.clear)
                }
                
                Spacer()
                
                Text("Set Reminder")
                    .font(.headline)
                    .bold()
                
                Spacer()
                
                Button {
                    dismiss()
                }label: {
                    Image("check")
                        .frame(width: 48, height: 48)
                        .background(Color.button)
                        .cornerRadius(60)
                        .glassEffect(.clear)
                }
                

            }
            .padding()
            Spacer()
            
            
            ScrollView {
                VStack(spacing: 40) {
                    VStack(spacing: 1) {
                        HStack {
                            Text("Plant Name")
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .bold()
                                .frame(width: 120, alignment: .leading)
                            
                            Spacer()
                            
                            TextField("Pothos", text: $plantName)
                                .textFieldStyle(.plain)
                        }
                        .frame(width: 330, height: 25)
                        .padding()
                        .background(Color.field)
                        .cornerRadius(60)
                    }
                
                    
                    VStack(spacing: 1) {
                        HStack {
                            Image("location 1")
                            Text("Room")
                                .frame(width: 120, alignment: .leading)
                            
                            Spacer()
                            
                            Picker("Room", selection: $selectedRoom) {
                                ForEach(rooms, id: \.self) { room in
                                    Text(room).tag(room)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                        .padding(.horizontal)
                        
                        Divider()
                            .padding(.horizontal)
                        
                        HStack {
                            Image("sun")
                            Text("Light")
                                .frame(width: 120, alignment: .leading)
                            
                            Spacer()
                            
                            Picker("Light", selection: $selectedLight) {
                                ForEach(lightOptions, id: \.self) { light in
                                    Text(light).tag(light)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                        .padding(.horizontal)
                    }
                    
                    .frame(width: 330, height: 44)
                    .padding()
                    .background(Color.field)
                    .cornerRadius(30)
                    // Apply tint to the container so both Pickers inherit it
                    .tint(Color.gray.opacity(0.8))
                    
                    VStack(spacing: 1) {
                        HStack {
                            Image("drop")
                            Text("Watering Days")
                                .frame(width: 120, alignment: .leading)
                            
                            Spacer()
                            
                            Picker("Days", selection: $wateringDay) {
                                ForEach(wateringDayOptions, id: \.self) { option in
                                    Text(option).tag(option)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                        .padding(.horizontal)
                        
                        Divider()
                            .padding(.horizontal)
                        
                        HStack {
                            Image("drop")
                            Text("Water")
                                .frame(width: 120, alignment: .leading)
                            
                            Spacer()
                            
                            Picker("Water", selection: $watering) {
                                ForEach(wateringOptions, id: \.self) { option in
                                    Text(option).tag(option)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                        .padding(.horizontal)
                    }
                    .frame(width: 330, height: 44)
                    .padding()
                    .background(Color.field)
                    .cornerRadius(30)
                    // Apply tint to the container so both Pickers inherit it
                    .tint(Color.gray.opacity(0.8))
                    Spacer()
                    Button("Delete Reminder") {
                       
                    }
                    .frame(width: 330, height: 18)
                    .padding()
                    .background(Color.field)
                    .cornerRadius(30)
                    .foregroundColor(.red)
                 
                }
                .padding()
            }
            
            Spacer()
        }
    }
}

#Preview {
    EditSheet()
}


