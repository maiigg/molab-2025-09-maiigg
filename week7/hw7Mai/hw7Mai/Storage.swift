//
//  Storage.swift
//  hw7Mai
//

import SwiftUI
import Combine

@MainActor
class Storage: ObservableObject {
    @Published var savedImages: [UIImage] = []
}
