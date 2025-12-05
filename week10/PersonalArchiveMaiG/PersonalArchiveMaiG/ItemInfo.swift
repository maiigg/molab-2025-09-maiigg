import Foundation
// I had to add all of these initialisers that supply UUID's if not present, and custom decoders that ChatGPT coded for me because the JSON files wouldn't load any other way, I worked for 1.5 hours to try to get it to work
//this is my conversation with chatgpt about debugging and getting my json file to actually LOAD!!!!!!
//https://chatgpt.com/share/691fe32d-17ac-8007-83cc-158647ef2120
// The problem Chat Pointed Out:
//decoding fails because the JSON doesn’t have "id" for each object 
//On the simulator, you probably already saved once, so model.json in Documents has id fields, so it decodes fine. On a fresh device install, it only has the bundled JSON (no id), so it crashes.
//Key bit is:
// id = try container.decodeIfPresent(UUID.self, forKey: .id) ?? UUID()
// So if id is missing in JSON (like in your bundled model.json), it just makes a new one.
struct ItemInfo: Identifiable, Codable {
    var id: UUID
    var url: String
    var webURL: String
    var title: String
    var garmentType: String
    var origin: String
    var decade: Int
    var colours: [String]
    var materials: [String]
    var optExtraInfo: [String]

    // Normal init for use in code
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

    enum CodingKeys: String, CodingKey {
        case id, url, webURL, title, garmentType, origin, decade, colours, materials, optExtraInfo
    }

    // Custom decoder: gives default values when keys are missing
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

