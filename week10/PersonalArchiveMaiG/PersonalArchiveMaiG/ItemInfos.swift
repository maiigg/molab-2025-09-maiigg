//
//  ItemInfos.swift
//  PersonalArchiveMaiG
//
//  Created by Mai Gourlay on 2025/11/20.
//
import Foundation
import SwiftUI

struct ItemInfos: Codable {
    var objects = [ItemInfo]()
    
    init () {
        objects = [];
    }
    mutating func addObj(item: ItemInfo) {
        objects.append(item)
    }
    mutating func updateItem(item: ItemInfo) {
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

