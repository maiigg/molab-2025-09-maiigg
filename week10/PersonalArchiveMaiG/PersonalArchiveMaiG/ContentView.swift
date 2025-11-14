//
//  ContentView.swift
//  PersonalArchiveMaiG
//
//  Created by m Gourlay on 2025/11/14.
//

import SwiftUI


struct ContentView: View {
    
    @State private var selectedTab = 0
    
    
    var body: some View {
        let bubbleGumPink = Color(red: 9.9, green: 0.7, blue: 0.9)
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
        }
        }

            
        }
    

   
#Preview {
    ContentView()
}
