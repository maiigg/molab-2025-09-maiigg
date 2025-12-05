//
//  SearchView.swift
//  PersonalArchiveMaiG
//
//  Created by Mai Gourlay on 2025/11/24.
//
import SwiftUI

extension ItemInfo {
    var decadeGroup: Int {
        (decade / 10) * 10
    }
} // i was making this search bar and realised i didnt want days like 1838 being in the selection, instead, i want to generally group by decade so 1838 would fall into 1830s, did a quick calculation utilsiing Int's round down to make it work

//used the same async thumbnail from contentView but converted it into its own struct
struct AsyncThumbnail: View {
    let url: String
    @State private var image: UIImage?

    var body: some View {
        ZStack {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .overlay(ProgressView())
            }
        }
        .task {
            image = await imageFor(string: url)
        }
    }
}
 
struct SearchView: View {
    @EnvironmentObject var document: Document
    @State private var query: String = ""
    @State private var selectedDecade: Int? = nil
    
    var decades: [Int] {
        var list: [Int] = []
        for item in document.object.objects {
            let dec = item.decadeGroup
            if !list.contains(dec) {
                list.append(dec)
            }
        }
        return list.sorted()
    }
    var filteredItems: [ItemInfo] {
        document.object.objects.filter { item in
            //checks to see if ANYTHING (why it is all OR operators) matches
            let matchesText = query.isEmpty ||
                item.garmentType.localizedCaseInsensitiveContains(query) ||
                item.title.localizedCaseInsensitiveContains(query) ||
                //cause theyre arrays they need to be joined/split to check each one
                item.materials.joined(separator: " ").localizedCaseInsensitiveContains(query) ||
                item.colours.joined(separator: " ").localizedCaseInsensitiveContains(query)
            
            //checks decade
            let matchesDecade = selectedDecade == nil || selectedDecade == item.decadeGroup
            
            return matchesText && matchesDecade

        }
    }
    
    var body: some View {
        VStack {
            //search bar
            TextField("Search by type, material, colour...", text: $query)
                .textFieldStyle(RoundedBorderTextFieldStyle())
               // .padding()
            Picker("Decade", selection: $selectedDecade) {
                  Text("All Decades...").tag(nil as Int?)
                  ForEach(decades, id: \.self) { decade in
                      Text("\(String(decade))s") .tag(Optional(decade))
                  }
              }
              .pickerStyle(WheelPickerStyle())
              .padding(.horizontal)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                    ForEach(filteredItems) { item in
                        NavigationLink {
                            UpdateImageView(item: item)
                        } label: {
                            VStack {
                                AsyncThumbnail(url: item.url)
                                    .frame(height: 150)
                                    .cornerRadius(10)
                                
                                Text(item.garmentType.capitalized)
                                    .font(.caption)
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                }
                .padding()
            }
            
                      
        }
    }
}
