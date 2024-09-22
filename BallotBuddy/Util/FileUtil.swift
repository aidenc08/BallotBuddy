//
//  FileUtil.swift
//  BallotBuddy
//
//  Created by Aiden Chavda on 8/27/24.
//

import Foundation

struct FileUtil {
    static func writeToFile<T: Encodable>(fileName: String, data: T) -> Bool{
        let filePath = self.getDocumentsDirectory().appendingPathComponent(fileName)
        
        do {
            let JSONdata = try JSONEncoder().encode(data)
            print(fileName)
            print(filePath.absoluteString)
            print("Encoded")
            try JSONdata.write(to: filePath)
            print("Wrote")
            return true
        }
        catch {
            print("Did Not Encode or Write")
            return false
        }
        
        
    }
    
    static func writeToTextFile(fileName: String, text: String) -> Bool {
        let filePath = self.getDocumentsDirectory().appendingPathComponent(fileName)
        
        do {
            try text.write(to: filePath, atomically: false, encoding: .utf8)
            return true
        }
        catch {
            print("Did Not Encode or Write")
            return false
        }
    }
    
    static func readFromTextFile(fileName: String) -> String {
        let filePath = self.getDocumentsDirectory().appendingPathComponent(fileName)
        
        do {
            let data = try String(contentsOfFile: filePath.path)
            return String(data)
        }
        catch {
            print("Did Not Encode or Write")
            return ""
        }
    }
    
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    static func checkIfFileExists(fileName: String) -> Bool {
        let filePath = self.getDocumentsDirectory().appendingPathComponent(fileName)
        return FileManager.default.fileExists(atPath: filePath.path)
    }
    static func readFile<T: Decodable>(fileName: String, as type: T.Type = T.self) -> T? {
        let filePath = self.getDocumentsDirectory().appendingPathComponent(fileName)
        do {
            let data = try String(contentsOfFile: filePath.path).data(using: .utf8)
            let user = try JSONDecoder().decode(T.self, from: (data)!)
            return user
        }
        catch {
            print("Read Failed")
        }
        return nil
    }
    
    static func deleteFile(fileName: String) -> Bool {
        let filePath = self.getDocumentsDirectory().appendingPathComponent(fileName)
        do {
            try FileManager.default.removeItem(at: filePath)
            return true
        }
        catch {
            return false
        }
    }
    
    static func loadJSON<T: Decodable>(_ filename: String, as type: T.Type = T.self) -> T {
        let data: Data

        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
    
    

}
