//
//  ObjModels.swift
//  hw6Mai
//
//  Code adapted from JHT's ImageEditDemoJSON

import Foundation
import SwiftUI

struct ObjModels: Codable {
    var objects = [ObjModel]()
    
    init () {
        objects = [];
    }
    mutating func addObj(item: ObjModel) {
        objects.append(item)
    }
    mutating func updateItem(item: ObjModel) {
        if let index = findIndex(item.id) {
            objects[index] = item;
        }
    }
    mutating func deleteItem(id: UUID) {
        if let index = findIndex(id) {
            objects.remove(at: index)
        }
    }
    func findIndex(_ id: UUID) -> Int? {
        return objects.firstIndex { item in item.id == id }
    }
}
