//
//  ContentView.swift
//  hw8Mai
//
//  Created by Mai Gourlay on 2025/10/29.
//

//potential filter gallery like photobooth on the mac

import SwiftUI

struct ContentView: View {
    @StateObject var model = Model()
    
    var body: some View {
        ZStack {
            GalleryView(model: model)
        }
        .onAppear {  //used from CaptureRecorder 
            model.checkPermissions()
            model.setupSession()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
