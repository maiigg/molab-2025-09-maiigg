//  ContentView.swift
//  hw4Mai
//  Created by mai Gourlay on 2025/10/01.
// https://www.swiftyplace.com/blog/swiftui-font-and-texts
//relied on this website a lot for CUSTOMIZATION OF THE SCREEN

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            ZStack{
                //DEPTH OF SCREEN E.G. XYZ
                // COLOR FOR BKGROUND FIRST/BOTTOM OF THE STACK SO EVERYTHING CAN BE PLACED ON IT
                Color.cyan.ignoresSafeArea()
                //makes sure that the top bits are coloured in too
                VStack(spacing: 40){
                    Text("Welcome! Touch Any Emoji You Want And See What Happens!")
                        .font(.subheadline)
                        .bold()
                        .multilineTextAlignment(.center)
                    //centres
                    Text("Press Play")
                        .font(.subheadline)
                        .bold()
                        .multilineTextAlignment(.center)
                    //centres
                        .padding()
                    NavigationLink (destination: Party()) {
                        Text("PLAY")
                        .frame(width: 200, height: 60)
                        // BUTTON SIZE
                        .background(Color.red)
                        // BUTTON COLOUR
                        .buttonStyle(.bordered)
                        //ADD A BORDER
                        .cornerRadius(10)
                        //ROUNDED
                        .padding()
                    }
                    
                   
                    
                    //  NavigationLink(destination:){
                    .navigationTitle("Emoji Noise!")
                        
                    
                }
               
                
            }
        }
        
    }
}

#Preview {
    ContentView()
}
