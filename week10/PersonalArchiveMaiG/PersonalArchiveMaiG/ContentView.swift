//
//  ContentView.swift
//  PersonalArchiveMaiG
//
//  Created by m Gourlay on 2025/11/14.
//

import SwiftUI


struct ContentView: View {
    
    @State private var selectedTab = 0
    @EnvironmentObject var document: Document
    
    
    var body: some View {
        TabView(selection: $selectedTab){
            NavigationStack {
                
                VStack {
                    Text("Welcome to Your Archive")
                        .font(Font.largeTitle.bold())
                        .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    LinearGradient (colors: [Color.red,Color.yellow,Color.green, Color.blue,Color.purple],
                                    startPoint: .top,
                                    endPoint: .bottom)
                )
                
            }
            .tabItem {
                Image(systemName: "house")
            }
            .tag(0)
            NavigationStack {
                ArchiveGridView()
            }
            .tabItem {
                Image(systemName: "archivebox")
                Text("Archive")
            }
            .tag(1)
            NavigationStack {
                SearchView()
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
            .tag(2)
            NavigationStack {
                AddItemView()
            }
            .tabItem {
                Image(systemName: "plus")
                Text("Add Item")
            }
        }
        }

            
        }
    

   
#Preview {
    ContentView()
        .environmentObject(Document())
}
