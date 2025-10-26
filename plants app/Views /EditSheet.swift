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
    @EnvironmentObject private var viewModel: PlantViewModel
    @Environment(\.dismiss) var dismiss

    // Receive the plant to edit
    @State var editablePlant: Plant

    // Options
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

                Text("Edit Reminder")
                    .font(.headline)
                    .bold()

                Spacer()

                Button {
                    // Update the existing plant by ID
                    viewModel.update(editablePlant)
                    dismiss()
                } label: {
                    Image("check")
                        .frame(width: 48, height: 48)
                        .glassEffect(.clear)
                        .background(Color.button)
                        .cornerRadius(60)
                }
            }
            .padding()

            Spacer()

            ScrollView {
                VStack(spacing: 40) {
                    // Plant Name
                    VStack(spacing: 1) {
                        HStack {
                            Text("Plant Name")
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .bold()
                                .frame(width: 120, alignment: .leading)

                            Spacer()

                            TextField("Pothos", text: $editablePlant.plantName)
                                .textFieldStyle(.plain)
                        }
                        .frame(width: 330, height: 25)
                        .padding()
                        .background(Color.field)
                        .cornerRadius(60)
                    }

                    // Room + Light
                    VStack(spacing: 1) {
                        HStack {
                            Image("location 1")
                            Text("Room")
                                .frame(width: 120, alignment: .leading)

                            Spacer()

                            Picker("Room", selection: $editablePlant.selectedRoom) {
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

                            Picker("Light", selection: $editablePlant.selectedLight) {
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
                    .tint(Color.gray.opacity(0.8))

                    // Watering Day + Amount
                    VStack(spacing: 1) {
                        HStack {
                            Image("drop")
                            Text("Watering Days")
                                .frame(width: 120, alignment: .leading)

                            Spacer()

                            Picker("Days", selection: $editablePlant.wateringDay) {
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

                            Picker("Water", selection: $editablePlant.watering) {
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
                    .tint(Color.gray.opacity(0.8))

                    Spacer()

                    Button("Delete Reminder") {
                        // Delete by id using the convenience API
                        viewModel.remove(id: editablePlant.plantID)
                        dismiss()
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
    // Preview with a sample plant
    EditSheet(
        editablePlant: Plant(
            plantID: UUID(),
            plantName: "Pothos",
            selectedRoom: "Living Room",
            selectedLight: "Full Sun",
            wateringDay: "Every Day",
            watering: "20-50 ml",
//            isChecked: false
        )
    )
    .environmentObject(PlantViewModel())
}

