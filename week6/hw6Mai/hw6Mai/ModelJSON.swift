//  ModelJSON.swift
//  Created by jht2 on 1/15/22.
//
//  Modified from JHT'S ImageEditDemoJSON
//
import SwiftUI

extension ObjModels {
    
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
            self = try loadJSON(ObjModels.self, fileName: fileName)
        } catch {
            // fatalError("Model init error \(error)")
            print("Object init JSONfileName error \(error)")
        }
    }
}

