//  image.swift
// taken from ImageEditDemoJSON

import SwiftUI

// Read in an image from the array of url strings
func imageFor( index: Int) async -> UIImage  {
    let urlStr = imageArray[index % imageArray.count]
    return await imageFor(string: urlStr)!
}

// Read in an image from a url string
//func imageFor(string str: String) async -> UIImage!  {
//    guard let url = URL(string: str),
//          let imgData = try? Data(contentsOf: url),
//          let uiImage = UIImage(data:imgData)
//    else {
//        return nil
//    }
//    return uiImage
//}
func imageFor(string: String) async -> UIImage? {

    // 1. Check if it's a local file saved in Documents
    let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let localURL = documentsURL.appendingPathComponent(string)

    if FileManager.default.fileExists(atPath: localURL.path) {
        if let data = try? Data(contentsOf: localURL),
           let img = UIImage(data: data) {
            return img
        }
    }

    // 2. Otherwise treat it as a remote URL
    if let remoteURL = URL(string: string) {
        do {
            let (data, _) = try await URLSession.shared.data(from: remoteURL)
            return UIImage(data: data)
        } catch {
            return nil
        }
    }

    return nil
}
