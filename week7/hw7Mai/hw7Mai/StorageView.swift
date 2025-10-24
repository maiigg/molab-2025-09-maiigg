//
//  StorageView.swift
//  hw7Mai
//

import SwiftUI

struct StorageView: View {
    @EnvironmentObject var store: Storage
    //https://www.hackingwithswift.com/quick-start/swiftui/how-to-position-views-in-a-grid-using-lazyvgrid-and-lazyhgrid
    // for the classic camera roll grid
    
    let columns = [GridItem(.adaptive(minimum: 80),spacing: 10)]
    var body: some View {
        NavigationStack {
            ScrollView{
                LazyVGrid(columns: columns) {
                    ForEach(Array(store.savedImages.enumerated()), id: \.offset) { _, image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                    }
                }
                .padding(10)
                
            }
        }
        .navigationTitle("Saved Images")
        
    }
}
#Preview {
    StorageView()
        .environmentObject(Storage())
}
