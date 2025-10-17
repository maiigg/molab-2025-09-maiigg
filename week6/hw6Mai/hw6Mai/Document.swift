//
//  Document.swift
//  hw6Mai
//
import Foundation
import SwiftUI
internal import Combine

let imageArray = ["https://www.theperfectpuppyri.com/media/ap_media/MEXOFWYIALDC.jpg","https://slatercreekgoldenretrievers.com/wp-content/uploads/2023/03/127819769_m_normal_none.jpg"]


class Document: ObservableObject{
    @Published var object: ObjModels
    //var object: ObjModels
    
    let saveFileName = "model.json"
    
    let initSampleItems = true
    
    init() {
       // remove(fileName: saveFileName)
        object = ObjModels(JSONfileName: saveFileName);
        
        if initSampleItems && object.objects.isEmpty {
            // items for testing
            object.objects = []
            addObj(url: imageArray[1], name: "golden retriever", type: "dog", year: "2023")
            addObj(url: imageArray[0], name: "german shepherd", type: "dog" , year: "2025")
            
            
            
        }
    }
    func addObj(url:String,name:String,type:String,year:String){
        let newObj = ObjModel(id: UUID(),url: url, name: name, type: type, year: year)
        object.addObj(item: newObj)
    }
    func updateItem(item: ObjModel) {
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
    

