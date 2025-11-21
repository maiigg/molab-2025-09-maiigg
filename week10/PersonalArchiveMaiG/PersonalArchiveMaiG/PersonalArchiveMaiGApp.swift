//
//  PersonalArchiveMaiGApp.swift
//  PersonalArchiveMaiG
//
//  Created by Karen Gourlay on 2025/11/14.
//

import SwiftUI

@main
struct PersonalArchiveMaiGApp: App {
    @StateObject var document = Document()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(document)
        }
    }
}
