import SwiftUI

struct CheckboxItem{
    var name: String
    var isChecked: Bool
}

struct ckeckboxView: View {
    @Binding var item: CheckboxItem
    @State private var editReminder = false
    @ObservedObject var viewModel: PlantViewModel

    var body: some View{
        VStack(alignment: .leading){
            HStack(alignment: .top, spacing: 10) {
                Image(systemName: item.isChecked ? "checkmark.circle.fill": "circle")
                    .foregroundColor(item.isChecked ? .button : .gray)
                    .font(.system(size: 22))
                    .padding(.trailing, 4) // small space only to the right
                    .contentShape(Rectangle()) // make tap area easier
                    .onTapGesture {
                        item.isChecked.toggle()
                    }

                VStack(alignment: .leading, spacing: 6) {
                    HStack(spacing: 6) {
                        Image("location")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.gray)
                            .frame(width: 15, height: 15)

                        // Read from ObservedObject without using the projected value ($)
                        Text(viewModel.plant.selectedRoom)
                            .foregroundColor(.gray)
                            .font(.system(size: 15))
                    }

                    Text("\(viewModel.plant.plantName)")
                        .font(.system(size: 22, weight: .semibold)) // slightly smaller for tighter layout
                        .foregroundColor(.primary)

                    HStack(spacing: 8) {
                        HStack(spacing: 6) {
                            Image("sun")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(.fullSun)
                                .frame(width: 15, height: 15)

                            Text("\(viewModel.plant.selectedLight)")
                                .foregroundColor(.fullSun)
                                .font(.system(size: 14))
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.field)
                        .cornerRadius(8)

                        HStack(spacing: 6) {
                            Image("drop")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(.dropMll)
                                .frame(width: 10, height: 14)

                            Text("\(viewModel.plant.watering)")
                                .foregroundColor(.dropMll)
                                .font(.system(size: 14))
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.field)
                        .cornerRadius(8)
                    }
                }
            }
            .contentShape(Rectangle()) // make the whole row tappable
            .onTapGesture {
                editReminder = true
            }
            .sheet(isPresented: $editReminder) {
                EditSheet()
            }
        }
    }
}

struct checkView: View {
    @State private var progress: Double = 0.7 // 👈 demo progress
    @State private var yOffset: CGFloat = 0.0
    @State private var setReminder = false
    @State private var items = [
        CheckboxItem(name: "Potos", isChecked: false),
        CheckboxItem(name: "Flower", isChecked: false)

    ]
    @StateObject private var viewModel = PlantViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            Text("My Plants 🌱")
                .font(.system(size: 34, design: .default))
                .bold()
            
            Divider()
            
            VStack {
                Text("Your plants are waiting for a sip 💦")
                
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
            .padding(.bottom, 8)
            
            List {
                ForEach($items, id: \.name) { $item in
                    ckeckboxView(item: $item, viewModel: viewModel)
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12)) // tighter row insets
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(Color.clear)
            
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
        .padding()
    }
}

struct ckeckboxView_previews: PreviewProvider{
    static var previews: some View{
        checkView()
        
    }
}

#Preview {
    checkView()
}
