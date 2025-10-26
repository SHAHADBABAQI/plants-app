import SwiftUI

struct CheckboxItem{
    var name: String
    var isChecked: Bool
}

struct checkView: View {
    var progress: Double {
        guard !viewModel.plants.isEmpty else { return 0.0 }
        // Count only IDs that still exist in current plants
        let currentIDs = Set(viewModel.plants.map { $0.plantID })
        let validCheckedCount = checkedPlantIDs.intersection(currentIDs).count
        return Double(validCheckedCount) / Double(viewModel.plants.count)
    }
    var encouragementText: String {
        switch progress {
        case 0.0:
            return "Your plants are waiting for a sip 💦"
        case 0.0..<0.4:
            return "Nice! Keep watering 💧"
        case 0.4..<0.8:
            return "Great progress! 🌿"
        case 0.8..<1.0:
            return "Almost done! ☀️"
        default:
            return "All plants are watered! 🪴✨"
        }
    }
    @State private var setReminder = false

    // Track which plants are checked without changing your Plant model
    @State private var checkedPlantIDs: Set<UUID> = []

    // Track which plant is currently selected for editing
    @State private var plantToEdit: Plant?

    @EnvironmentObject var viewModel: PlantViewModel

    // Local delete handler to also clean up checked IDs
    private func delete(at offsets: IndexSet) {
        // Gather IDs that will be removed
        let idsToRemove = offsets.compactMap { index in
            viewModel.plants.indices.contains(index) ? viewModel.plants[index].plantID : nil
        }
        // Purge them from checked set
        idsToRemove.forEach { checkedPlantIDs.remove($0) }
        // Forward to view model
        viewModel.remove(at: offsets)
    }

    // Sorted plants: unchecked first, checked last
    private var sortedPlants: [Plant] {
        viewModel.plants.sorted { a, b in
            let aChecked = checkedPlantIDs.contains(a.plantID)
            let bChecked = checkedPlantIDs.contains(b.plantID)
            // Unchecked should come before checked
            if aChecked != bChecked {
                return aChecked == false && bChecked == true
            }
            // If both same status, keep stable order by name (or original index if desired)
            return a.plantName.localizedCaseInsensitiveCompare(b.plantName) == .orderedAscending
        }
    }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            List {
                // Header and progress inside a section header to keep List scrollable
                Section {
                    EmptyView()
                } header: {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("My Plants 🌱")
                            .font(.system(size: 34, design: .default))
                            .bold()
                            .foregroundColor(.white)

                        Divider()

                        VStack(spacing: 8) {
                            Text(encouragementText)
                                .foregroundColor(.white)

                            GeometryReader { geo in
                                ZStack(alignment: .leading) {
                                    // Background bar with rounded corners
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(Color.field)
                                        .frame(height: 8)

                                    // Progress fill with rounded corners
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(Color.button)
                                        .glassEffect()
                                        .frame(width: max(0, min(progress, 1)) * geo.size.width, height: 8)
                                        .animation(.easeInOut(duration: 1), value: progress)
                                }
                            }
                            .frame(height: 8) // constrain reader height
                        }
                        .padding(.top, 4)
                    }
                    .padding(.bottom, 8)
                }

                ForEach(sortedPlants, id: \.plantID) { plant in
                    let isChecked = checkedPlantIDs.contains(plant.plantID)
                    // Dim color when checked
                    let primaryTextColor: Color = isChecked ? .gray : .primary
                    let secondaryTextColor: Color = isChecked ? .gray.opacity(0.7) : .gray
                    let chipBackground: Color = Color.field
                    let sunColor: Color = isChecked ? .gray : .fullSun
                    let waterColor: Color = isChecked ? .gray : .dropMll
                    let checkColor: Color = isChecked ? .button : .gray

                    VStack(alignment: .leading) {
                        HStack(alignment: .top, spacing: 10) {
                            Image(systemName: isChecked ? "checkmark.circle.fill": "circle")
                                .foregroundColor(checkColor)
                                .font(.system(size: 22))
                                .padding(.trailing, 4)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    if isChecked {
                                        checkedPlantIDs.remove(plant.plantID)
                                    } else {
                                        checkedPlantIDs.insert(plant.plantID)
                                    }
                                }

                            VStack(alignment: .leading, spacing: 6) {
                                HStack(spacing: 6) {
                                    Image("location")
                                        .resizable()
                                        .renderingMode(.template)
                                        .foregroundColor(secondaryTextColor)
                                        .frame(width: 15, height: 15)

                                    Text(plant.selectedRoom)
                                        .foregroundColor(secondaryTextColor)
                                        .font(.system(size: 15))
                                }

                                Text(plant.plantName)
                                    .font(.system(size: 22, weight: .semibold))
                                    .foregroundColor(primaryTextColor)

                                HStack(spacing: 8) {
                                    HStack(spacing: 6) {
                                        Image("sun")
                                            .resizable()
                                            .renderingMode(.template)
                                            .foregroundColor(sunColor)
                                            .frame(width: 15, height: 15)

                                        Text(plant.selectedLight)
                                            .foregroundColor(sunColor)
                                            .font(.system(size: 14))
                                    }
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(chipBackground)
                                    .cornerRadius(8)
                                    .opacity(isChecked ? 0.6 : 1.0)

                                    HStack(spacing: 6) {
                                        Image("drop")
                                            .resizable()
                                            .renderingMode(.template)
                                            .foregroundColor(waterColor)
                                            .frame(width: 10, height: 14)

                                        Text(plant.watering)
                                            .foregroundColor(waterColor)
                                            .font(.system(size: 14))
                                    }
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(chipBackground)
                                    .cornerRadius(8)
                                    .opacity(isChecked ? 0.6 : 1.0)
                                }
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            plantToEdit = plant
                        }
                    }
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
                }
                // Note: onDelete uses original indices; we need to translate from sorted to original.
                // Easiest is to disable swipe-to-delete here and provide delete in EditSheet, or map indices.
                // We'll keep swipe delete by mapping offsets to original indices:
                .onDelete { offsets in
                    // Translate sorted offsets to original indices
                    let originalIndices = IndexSet(
                        offsets.compactMap { sortedIndex in
                            let plant = sortedPlants[sortedIndex]
                            return viewModel.plants.firstIndex(where: { $0.plantID == plant.plantID })
                        }
                    )
                    delete(at: originalIndices)
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(Color.clear)
            .padding(.horizontal) // keep similar padding feel

            // Floating button overlay so it doesn't affect List layout/scroll
            Button {
                setReminder.toggle()
            } label: {
                Image("plus")
                    .frame(width: 48, height: 48)
                    .background(Color.button)
                    .cornerRadius(60)
                    .glassEffect(.clear)
            }
            .padding(.trailing, 25)
            .padding(.bottom, 20)
            .sheet(isPresented: $setReminder) {
                ReminderSheet()
                    .environmentObject(viewModel)
            }
        }
        // Use item-based sheet to avoid blank content while item is nil
        .sheet(item: $plantToEdit, onDismiss: {
            plantToEdit = nil
        }) { plant in
            EditSheet(editablePlant: plant)
                .environmentObject(viewModel)
        }
    }
}

struct ckeckboxView_previews: PreviewProvider{
    static var previews: some View{
        checkView()
            .environmentObject(PlantViewModel())
    }
}

#Preview {
    checkView()
        .environmentObject(PlantViewModel())
}
