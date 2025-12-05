//
//  AddItemView.swift
//  PersonalArchiveMaiG
//
//  Created by Mai Gourlay on 2025/11/26.

// https://developer.apple.com/tutorials/sample-apps/capturingphotos-browsephotos
//
import SwiftUI
import PhotosUI

struct AddItemView: View {
    @EnvironmentObject var document: Document
    @Environment(\.dismiss) var dismiss
    
    //info to fill in
    @State private var titleText: String = ""
    @State private var garmentType: String = ""
    @State private var origin: String = ""
    @State private var decade: String = ""
    @State private var coloursText: String = ""
    @State private var materialsText: String = ""
    @State private var extraInfoText: String = "" //use as strings then split later
      //https://www.hackingwithswift.com/books/ios-swiftui/importing-an-image-into-swiftui-using-photospicker
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var selectedImage: UIImage?
    //https://www.devtechie.com/blog/mastering-photopicker-in-swiftui
    //https://www.hackingwithswift.com/quick-start/swiftui/how-to-let-users-select-pictures-using-photospicker
    // helped with learning how to implement PhotosPicker (specifcally the onChange and what that is supposed to be used for)
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .center, spacing: 20) {
                    PhotosPicker(selection: $selectedPhoto, matching: .images){
                        ZStack {
                            if let img = selectedImage {
                                Image(uiImage: img)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxHeight: 250)
                                    .cornerRadius(12)
                            }
                            else { //used from HackingWithSwift, see link above
                                ContentUnavailableView("No Picture", systemImage: "photo.badge.plus", description: Text("Import a photo to get started"))
                            }
                        }
                        
                    }
                    .onChange(of: selectedPhoto) {
                        Task {
                            if let selectedPhoto,
                               let data = try? await selectedPhoto.loadTransferable(type: Data.self),
                               let uiImage = UIImage(data: data) {
                                selectedImage = uiImage
                            }
                            else {
                                print("Fail")
                            }
                        }
                    }
                    Group {
                        AddField(title: "Name", text: $titleText)
                        AddField(title: "Garment Type", text: $garmentType)
                        AddField(title:"Origin", text: $origin)
                        AddField(title: "Year (e.g. 1830)", text: $decade)
                        AddField(title: "Colours (comma separated)", text: $coloursText)
                        AddField(title: "Materials (comma separated)", text: $materialsText)
                        AddField(title: "Extra Information (comma separated)", text: $extraInfoText)
                        
                    }
                    Button(action: saveItem) {
                        Text("Save Item")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.black)
                    }
                        .padding(.top)
                        .disabled(!canSave)
                        .opacity(canSave ? 1 : 0.5) // depends on whether all fields are completed yet
                }
                
            }
            
        }
    }
        var canSave: Bool {
            selectedImage != nil &&
            !titleText.isEmpty &&
            !garmentType.isEmpty &&
            !origin.isEmpty &&
            Int(decade) != nil &&
            !coloursText.isEmpty &&
            !materialsText.isEmpty
        }
        
    func saveItem() {
        guard let image = selectedImage,
              let filename = saveImageToDocuments(image),
              let decadeInt = Int(decade)
            else { return } //let all those be filled out
            //array stuff with these three
            let colours = coloursText
                .split(separator: ",")
                .map { $0.trimmingCharacters(in: .whitespaces) }
            let materials = materialsText
                .split(separator: ",")
                .map { $0.trimmingCharacters(in: .whitespaces) }
            
            let extraInfo = extraInfoText
                .split(separator: ",")
                .map { $0.trimmingCharacters(in: .whitespaces) }
            let newItem = ItemInfo(
                id: UUID(),
                url: filename,               //saved local file
                webURL: "", //erm ignore this
                title: titleText,
                garmentType: garmentType,
                origin: origin,
                decade: decadeInt,
                colours: colours,
                materials: materials,
                optExtraInfo: extraInfo
            )
            
            document.object.objects.append(newItem)   //added to document stuff
            document.saveModel()
//reinitialises everything when finished
        
            titleText = ""
            garmentType = ""
            origin = ""
            decade = ""
            coloursText = ""
            materialsText = ""
            extraInfoText = ""
            selectedImage = nil
            selectedPhoto = nil
                
            
            dismiss()
            
        }
        
        func saveImageToDocuments(_ image: UIImage) -> String? {
            let filename = UUID().uuidString + ".jpg"
            let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                .appendingPathComponent(filename)
            
            if let data = image.jpegData(compressionQuality: 0.85) {
                try? data.write(to: url)
                return filename
            }
            
            return nil
        }
    }
//used similar code to the loadJSON function but for accomodating the jpegs from the camera roll
//https://programmingwithswift.com/how-to-save-image-to-file-with-swift/?utm_source=chatgpt.com

//func loadJSON<T :Decodable>(_ type: T.Type, fileName: String) throws -> T {
//    let filePath = try documentPath(fileName: fileName)
//    if FileManager.default.fileExists(atPath: filePath.path) {
//        print("Loading JSON from Documents: \(filePath.path)")
//        let data = try Data(contentsOf: filePath)
//        return try JSONDecoder().decode(type, from: data)
//    
//    }
//    if let bundleURL = Bundle.main.url(forResource: fileName, withExtension: "json") {
//        print("Loading JSON from Bundle: \(bundleURL.path)")
//        let data = try Data(contentsOf: bundleURL)
//        return try JSONDecoder().decode(type, from: data)
//    }
//    print("Could not find \(fileName) in bundle or documents.")
//    throw FileError.missing
//}

    

    
struct AddField: View { //makes same type of textfields for each type of info
    let title: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            Text(title)
                .font(.headline)
            
            TextField("", text: $text)
                .padding(.vertical, 5)
                .background(Color(red: 0.5, green: 0.5, blue: 0.8))
        }
    }
}

