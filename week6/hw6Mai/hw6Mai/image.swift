//
//  image.swift
// taken from ImageEditDemoJSON

import SwiftUI

// Read in an image from the array of url strings
func imageFor( index: Int) async -> UIImage  {
    let urlStr = imageArray[index % imageArray.count]
    return await imageFor(string: urlStr)
}

// Read in an image from a url string
func imageFor(string str: String) async -> UIImage!  {
    guard let url = URL(string: str),
          let imgData = try? Data(contentsOf: url),
          let uiImage = UIImage(data:imgData)
    else {
        return nil
    }
    return uiImage
}

