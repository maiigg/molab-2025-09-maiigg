//
//  Document.swift
//  hw6Mai
//
import Foundation
import SwiftUI
internal import Combine

let imageArray = ["https://www.theperfectpuppyri.com/media/ap_media/MEXOFWYIALDC.jpg","https://slatercreekgoldenretrievers.com/wp-content/uploads/2023/03/127819769_m_normal_none.jpg"]
//from testing, ignore 

class Document: ObservableObject{
    @Published var object: ItemInfos
    //var object: ObjModels
    
    let saveFileName = "model.json"
    
    let initSampleItems = true
    
    init() {
       // remove(fileName: saveFileName)
        object = ItemInfos(JSONfileName: saveFileName);
        
        if initSampleItems && object.objects.isEmpty {
            // items for testing
            object.objects = []
       }
    }
    func addObj(url:String,webURL:String,title:String,garmentType:String,origin:String,decade: Int, colours: [String] = [],materials: [String] = []){
        let newObj = ItemInfo(id: UUID(),url: url, webURL: webURL,title:title, garmentType: garmentType, origin: origin, decade: decade, colours:colours,materials:materials)
        object.addObj(item: newObj)
    }
    func updateItem(item: ItemInfo) {
        object.updateItem(item: item);
        saveModel();
    }
    
    func deleteItem(id: UUID) {
        object.deleteItem(id: id)
        saveModel();
    }
    
    
    func saveModel() {
        print("Document saveModel")
        object.saveAsJSON(fileName: saveFileName)
    }
    
        
    }
    

