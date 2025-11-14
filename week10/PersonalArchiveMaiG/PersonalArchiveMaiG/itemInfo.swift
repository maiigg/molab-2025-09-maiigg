//
//  itemInfo.swift
//  PersonalArchiveMaiG
//
import Foundation

struct itemInfo: Identifiable, Codable {
    var id = UUID()
    var url:String = "" //image url?
    var webURL:String = "" //url to go to website potentially
    var garmentType:String = ""
    var origin:String = ""
    var decade: Int = 0
    var colours:[String] = []
    var materials:[String] = []
    var optExtraInfo: [String] = []
}


