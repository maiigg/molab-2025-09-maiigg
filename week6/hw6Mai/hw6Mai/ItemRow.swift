import SwiftUI


struct ItemRow: View {
    var item:ObjModel
    
    @State var uiImage:UIImage?
    
    var body: some View {
        HStack {
            ZStack {
                if !item.name.isEmpty {
                    Image(item.name)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:100, height: 100)
                }
                if let uiImage {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:100, height: 100)
                }
                
            }
            Text(item.name)
            Spacer()
        }
        .task {
            uiImage =  await imageFor(string: item.url)
        }
    }
}


#Preview {
  ItemRow(item: ObjModel(name: "I am not a fish", type: "fish"))
        .environmentObject(Document())
}
