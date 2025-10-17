//
//  ObjModel.swift
//  hw6Mai
//
//  Created by Mai Gourlay on 2025/10/16.
//

import Foundation

struct ObjModel: Identifiable, Codable {
    var id = UUID()
    var url:String = ""
    var name:String = ""
    var type:String = ""
    var year:String = ""
    // tried to make year an int but textField refused to cooperate unless it was a string
}
