
//  Credit to JHT ImageEditDemoJSON
// tweaked it to my own liking but original still made by JHT

import SwiftUI

struct UpdateImageView: View {
    @State var item: ItemInfo
    
    @State var uiImage:UIImage?
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var document: Document

    var body: some View {
        VStack {
           
            if !item.garmentType.isEmpty {
                Image(item.garmentType)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            
            if let uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .cornerRadius(12)
                    .shadow(radius: 5)
            }
            Text(item.title.capitalized)
                .font(.title2)
                .bold()
            HStack {
                Text(item.origin)
                Text("·")
                Text("Date: ca. \(String(item.decade))") //parse as string to get rid of comma ha
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
          
            VStack(alignment: .center, spacing: 4) {
                Text("Type:")
                    .font(.headline)
                Text(item.garmentType)
            }
            VStack(alignment: .center, spacing: 4) {
               Text("Materials:")
                   .font(.headline)
               Text(item.materials.joined(separator: ", "))
            }
            VStack(alignment: .center, spacing: 4) {
                Text("Colours:")
                    .font(.headline)
                Text(item.colours.joined(separator: ", "))
            }
            if !item.optExtraInfo.isEmpty {
                VStack(alignment: .center, spacing: 4) {
                    Text("Additional Info")
                        .font(.headline)
                    ForEach(item.optExtraInfo, id: \.self) { info in
                        Text("• \(info)")
                    }
                }
            }

        HStack {
            Button("Update") {
                    print("UpdateImageView Update")
                    document.updateItem(item: item)
                    dismiss()
                
            }
            Spacer()
            Button("Delete") {
                
                    document.deleteItem(id: item.id)
                    dismiss();
                
            }
        }.padding(10)
//            Form {
//                Text("Garment: " + item.garmentType)
//                TextField("Origin", text: $item.origin)
//                    .textInputAutocapitalization(.never)
//                    .disableAutocorrection(true)
//              //  numeric input alternative
//            }
        
    }
    .task {
        uiImage =  await imageFor(string: item.url)
        }
    }
}

struct UpdateImageView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateImageView(item: ItemInfo())
            .environmentObject(Document())
        // .environment(Document())
        
    }
}
