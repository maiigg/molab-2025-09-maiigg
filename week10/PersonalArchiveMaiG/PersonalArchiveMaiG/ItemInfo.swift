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
    
    init(
            id: UUID = UUID(),
            url: String = "",
            webURL: String = "",
            title: String = "",
            garmentType: String = "",
            origin: String = "",
            decade: Int = 0,
            colours: [String] = [],
            materials: [String] = [],
            optExtraInfo: [String] = []
        ) {
            self.id = id
            self.url = url
            self.webURL = webURL
            self.title = title
            self.garmentType = garmentType
            self.origin = origin
            self.decade = decade
            self.colours = colours
            self.materials = materials
            self.optExtraInfo = optExtraInfo
        }
    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decodeIfPresent(UUID.self, forKey: .id) ?? UUID()
            url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
            webURL = try container.decodeIfPresent(String.self, forKey: .webURL) ?? ""
            title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
            garmentType = try container.decodeIfPresent(String.self, forKey: .garmentType) ?? ""
            origin = try container.decodeIfPresent(String.self, forKey: .origin) ?? ""
            decade = try container.decodeIfPresent(Int.self, forKey: .decade) ?? 0
            colours = try container.decodeIfPresent([String].self, forKey: .colours) ?? []
            materials = try container.decodeIfPresent([String].self, forKey: .materials) ?? []
            optExtraInfo = try container.decodeIfPresent([String].self, forKey: .optExtraInfo) ?? []
        }
    
}
