//
//  FileUtil.swift
//  BallotBuddy
//
//  Created by Aiden Chavda on 8/27/24.
//

import Foundation

struct FileUtil {
    func writeToFile(fileName: String, data: User) -> Bool{
        let filePath = self.getDocumentsDirectory().appendingPathComponent(fileName)
        
        do {
            let JSONdata = try JSONEncoder().encode(data)
            try JSONdata.write(to: filePath)
            return true
        }
        catch {
            print("Did Not Encode or Write")
            return false
        }
        
        
    }
    
    func writeToTextFile(fileName: String, text: String) -> Bool {
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
    
    func readFromTextFile(fileName: String) -> String {
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
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func checkIfFileExists(fileName: String) -> Bool {
        let filePath = self.getDocumentsDirectory().appendingPathComponent(fileName)
        return FileManager.default.fileExists(atPath: filePath.path)
    }
    func readFile(fileName: String) -> User {
        let filePath = self.getDocumentsDirectory().appendingPathComponent(fileName)
        do {
            let data = try String(contentsOfFile: filePath.path).data(using: .utf8)
            let user = try JSONDecoder().decode(User.self, from: (data)!)
            return user
        }
        catch {
            print("Read Failed")
        }
        return User()
    }
    
    func deleteFile(fileName: String) -> Bool {
        let filePath = self.getDocumentsDirectory().appendingPathComponent(fileName)
        do {
            try FileManager.default.removeItem(at: filePath)
            return true
        }
        catch {
            return false
        }
    }
    
    func loadJSON<T: Decodable>(_ filename: String, as type: T.Type = T.self) -> T {
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
