//  ModelJSON.swift
//  Created by jht2 on 1/15/22.
//
//  Modified from JHT'S ImageEditDemoJSON
//
import SwiftUI
extension ItemInfos {
    func saveAsJSON(fileName: String) {
        do {
            try saveJSON(fileName: fileName, val: self);
        }
        catch {
            fatalError("Model saveAsJSON error \(error)")
        }
    }
    
    init(JSONfileName fileName: String) {
           objects = []

           do {
               self = try loadJSON(ItemInfos.self, fileName: fileName)
           } catch {
               print("Could not load from Documents, trying bundle... Error: \(error)")

               let name = (fileName as NSString).deletingPathExtension
               let ext = (fileName as NSString).pathExtension

               if let bundleURL = Bundle.main.url(forResource: name, withExtension: ext) {
                   do {
                       let data = try Data(contentsOf: bundleURL)
                       let decoded = try JSONDecoder().decode(ItemInfos.self, from: data)
                       self = decoded
                       print("Loaded JSON from bundle")
                   } catch {
                       print("Failed decoding JSON: \(error)")
                       self.objects = []
                   }
               } else {
                   print("JSON not found in bundle at \(name).\(ext)")
                   self.objects = []
               }
           }
       }
   }
    
