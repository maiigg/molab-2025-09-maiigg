//
//  CharacterProfile.swift
//  hw7Mai
//
import SwiftUI
import Foundation

struct CharacterProfile: Identifiable, Codable {
    let id: UUID
    let name: String
    var imageData: Data     //will store the image here
    
    var image: Image? {
            if let uiImage = UIImage(data: imageData) {
                return Image(uiImage: uiImage)
            }
            return nil
        }
    
}
