//
//  Edit.swift
//  hw7Mai
// tab view just for organising
//based on InstaFilter Project from JHT
import SwiftUI


struct ContentView: View {
    
    @StateObject private var store = Storage()
    
    @State private var selectedTab = 0
    
    
    var body: some View {
        //https://www.youtube.com/watch?v=JqQQozkFeJU
        //https://developer.apple.com/documentation/SwiftUI/TabView 
        TabView(selection: $selectedTab){
            NavigationStack {
                VStack {
                    Text("Edit and Save Photos!")
                        .font(.title)
                        .padding()
//                    NavigationLink("Go to Edit Page") {
//                        Edit()
//                    }
//                    .buttonStyle(.borderedProminent)
                }
                .navigationTitle("Home")
            }
            .tabItem {
                Image(systemName: "house")
            }
            .tag(0)
                    Edit()
                        .environmentObject(store) //when debugging, chatgpt recommends me to place these everywhere
                        .tabItem {
                            Image(systemName: "star")
                            Text("Editing")
                        }
                        .tag(1)
                    StorageView()
                        .environmentObject(store)
                        .tabItem {
                            Image(systemName: "photo.on.rectangle")
                            Text("Storage")
                        }
                        .tag(2)
                }

            
        }
    }

   
#Preview {
    ContentView()
}
