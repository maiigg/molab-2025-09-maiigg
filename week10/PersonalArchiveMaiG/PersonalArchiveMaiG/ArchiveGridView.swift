//
//  ArchiveGridView.swift
//  PersonalArchiveMaiG
//
//  Created by Mai Gourlay on 2025/11/20.
// creates the format of how I want the archive to look like: like a camera roll

import SwiftUI
// inspired by my Homework 8 where I also used LazyGrid to make a camera roll gallery with edited photos
struct ArchiveGridView: View {
    @EnvironmentObject var document: Document
    let columns = [ //3 columns
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    var body: some View {
        ScrollView {
            //based this off of my hw8 where I did the same grid system, except utilised new thing called AsyncImage which is for URL's instead of the given CGImages in that one 
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(document.object.objects) { item in
                    NavigationLink(destination: UpdateImageView(item: item)) {
                        VStack {
                            AsyncImage(url: URL(string: item.url)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 150)
                                    .clipped()
                                    .cornerRadius(8)
                                }placeholder: {
                                    Color.gray
                                        .frame(height: 100)
                                        .cornerRadius(8)
                                }
                            Text(item.title)
                                .font(.caption)
                                .foregroundColor(.primary)
                        }
                    }
                }
            }
        }
        .navigationTitle("Archive")
    }
}
