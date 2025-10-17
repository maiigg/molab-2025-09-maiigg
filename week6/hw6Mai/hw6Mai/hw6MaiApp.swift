//  hw6MaiApp.swift
//  hw6Mai
//
//  Created by m Gourlay on 2025/10/16.
//

import SwiftUI

@main
struct hw6MaiApp: App {
    @StateObject private var document = Document()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(document)
        }
    }
}
