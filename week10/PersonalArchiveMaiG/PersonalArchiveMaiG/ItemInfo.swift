import Foundation
// I had to add all of these initialisers that supply UUID's if not present, and custom decoders that ChatGPT coded for me because the JSON files wouldn't load any other way, I worked for 1.5 hours to try to get it to work
//this is my conversation with chatgpt about debugging and getting my json file to actually LOAD!!!!!!
//https://chatgpt.com/share/691fe32d-17ac-8007-83cc-158647ef2120
struct ItemInfo: Identifiable, Codable {
    var id: UUID = UUID()
    var url:String = "" //image url?
    var webURL:String = "" //url to go to website potentially
    var title: String = ""
    var garmentType:String = ""
    var origin:String = ""
    var decade: Int = 0
    var colours:[String] = []
    var materials:[String] = []
    var optExtraInfo: [String] = []
    
        
    
}
