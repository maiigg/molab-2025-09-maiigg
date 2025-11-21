//
//  SaveLoadJSON
//
//  Created by jht2 on 10/25/23.
//  Taken and slightly modified from JHT'S ImageEditDemoJSON

import Foundation

// Where is generic defined? WHat's this <T: Encodable>
//

// Write a value to file that will be stored in the documents directory as JSON
//  fileName - name of file with to store
//  val - the value to store in the file
//
func saveJSON<T: Encodable>(fileName: String, val: T) throws {
    let filePath = try documentPath(fileName: fileName);
    print("saveJSON filePath \(filePath as Any)")
    
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    
    let jsonData = try encoder.encode(val)
    // print("Model saveAsJSON jsonData \(String(describing: jsonData))")
    
    let str = String(data: jsonData, encoding: .utf8)!
    // print("Model saveAsJSON encode str \(str)")
    
    // Terminal command 'cp' to copy output file to Downloads folder
    // The trailing period means use the same file name as the source
    print("Model saveAsJSON encode str \(filePath as Any)")
    print("cp \(filePath.absoluteString.dropFirst(7)) ~/Downloads/." )

    try str.write(to: filePath, atomically: true, encoding: .utf8)
}

func loadJSON<T :Decodable>(_ type: T.Type, fileName: String) throws -> T {
    let filePath = try documentPath(fileName: fileName)
    if FileManager.default.fileExists(atPath: filePath.path) {
        print("Loading JSON from Documents: \(filePath.path)")
        let data = try Data(contentsOf: filePath)
        return try JSONDecoder().decode(type, from: data)
    
    }
    if let bundleURL = Bundle.main.url(forResource: fileName, withExtension: nil) {
            print("Loading JSON from Bundle: \(bundleURL.path)")
            let data = try Data(contentsOf: bundleURL)
            return try JSONDecoder().decode(type, from: data)
        }
    print("Could not find \(fileName) in bundle or documents.")
    throw FileError.missing
}

enum FileError: Error {
    case missing
}

// Remove a file from the documents directory
//  fileName - the name of the file to remove
//
func remove(fileName: String) {
    do {
        let filePath = try documentPath(fileName: fileName);
        try FileManager.default.removeItem(at: filePath)
    } catch {
        // fatalError("Model init error \(error)")
        print("remove fileName error \(error)")
    }
}

// Return the path the a file in the user documents directory
//  fileName - name of file
//
func documentPath(fileName: String, create: Bool = false) throws -> URL {
    let directory = try FileManager.default.url(
        for: .documentDirectory,
        in: .userDomainMask,
        appropriateFor: nil,
        create: create)
    return directory.appendingPathComponent(fileName);
}





