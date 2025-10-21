import SwiftUI

struct CheckboxItem{
    var name: String
    var isChecked: Bool
}

struct ckeckboxView: View {
    @Binding var item: CheckboxItem
    var body: some View{
        
        HStack{
            Image(systemName: "circle")
                .foregroundColor(.gray)
                .font(.system(size: 22))
            Spacer()
            Text(item.name)
        }
    }
    
    
}

struct checkView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            Text("My Plants 🌱")
                .font(.system(size: 34, design: .default))
                .bold()
            
            Divider()
            
            VStack {
                Text("Your plants are waiting for a sip 💦")
                
                Rectangle()
                    .frame(height: 8)
                    .foregroundColor(.field)
                    .cornerRadius(4)
            }
            .padding(.bottom, 8)
            
            List {
                
                Section {
                
                }
            }
            .listStyle(.insetGrouped) // choose a style you like
        }
        .padding()
    }
}

struct ckeckboxView_previews: PreviewProvider{
    static var previews: some View{
        ckeckboxView(item: .constant(CheckboxItem(name: "botos plant", isChecked: false)))
    }
}

//#Preview {
//    checkView()
//}
