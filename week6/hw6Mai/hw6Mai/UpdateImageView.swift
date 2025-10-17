//
//  UpdateImageView.swift
//  ImageEditDemo
//
//  Created by jht2 on 3/3/22.
//  Credit to JHT ImageEditDemoJSON

import SwiftUI

struct UpdateImageView: View {
    @State var item: ObjModel
    
    @State var uiImage:UIImage?
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var document: Document

    var body: some View {
        VStack {
            ZStack {
                if !item.name.isEmpty {
                    Image(item.name)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                if let uiImage {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
            HStack {
                Button("Update") {
                    if loggedInUser == "guest"{
                        print("Guest Cannot Update")
                    }
                    else{
                        print("UpdateImageView Update")
                        document.updateItem(item: item)
                        dismiss()
                    }
                }
                Spacer()
                Button("Delete") {
                    if loggedInUser == "guest" {
                        print("Guest Cannot Delete")
                    }
                    else{
                        document.deleteItem(id: item.id)
                        dismiss();
                    }
                    
                }
            }.padding(10)
            Form {
                TextField("url", text: $item.url)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                TextField("name", text: $item.name)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
//                TextField("systemName", text: $item.year)
//                    .textInputAutocapitalization(.never)
//                    .disableAutocorrection(true)
                TextField("type", text: $item.type)
                    .textInputAutocapitalization(.never)
                TextField("year",text: $item.year)
                    .textInputAutocapitalization(.never)
            }
        }
        .task {
            uiImage =  await imageFor(string: item.url)
        }
    }
}

struct UpdateImageView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateImageView(item: ObjModel())
       // .environment(Document())

    }
}
