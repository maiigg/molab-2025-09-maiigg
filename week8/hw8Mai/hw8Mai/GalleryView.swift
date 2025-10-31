//
//  GalleryView.swift
//  hw8Mai
//
//  Created by Mai Gourlay on 2025/10/29.
//

import SwiftUI

struct GalleryView: View {
    
    @ObservedObject var model: Model
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        //utilised from my last homework for grids for photo storage
        ScrollView {
            LazyVGrid(columns: columns, spacing: 6) {
                ForEach(model.filteredPreviews, id: \.0) { effect, cgImage in
                    VStack{
                        Image(cgImage, scale: 1.0, orientation: .upMirrored, label: Text(effect.rawValue))
                            .resizable()
                            .scaledToFill()
                            .clipped()
                        
                        Text(effect.rawValue)
                            .font(.caption)
                            .foregroundColor(.white)
                    }
                    
                }
                
            }
            
            
        }
        .background(Color(.black))
    }
    
}
