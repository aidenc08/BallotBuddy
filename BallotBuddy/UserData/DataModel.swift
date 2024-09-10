//
//  DataModel.swift
//  BallotBuddy
//
//  Created by Aiden Chavda on 8/27/24.
//

import Foundation

struct DataModel {
    static let userDataFileName = "_user"
    
    static func getUser() -> User? {
        if (FileUtil.checkIfFileExists(fileName: userDataFileName)) {
            let user = FileUtil.readFile(fileName: userDataFileName, as: User.self)
            return user
        }
        else {
            return nil
        }
    }
    
    static func saveUser(u: User) {
        FileUtil.writeToFile(fileName: userDataFileName, data: u)
    }
    
    static func deleteUser() {
        FileUtil.deleteFile(fileName: userDataFileName)
    }
    
    static func getMailInRegistrationItems() -> [RegistrationItem] {
        return FileUtil.loadJSON("mail.json", as: [RegistrationItem].self)
    }
    
    static func getInPersonRegistrationItems() -> [RegistrationItem] {
        return FileUtil.loadJSON("in_person.json", as: [RegistrationItem].self)
    }
    
    static func saveRaces(zip: String, races: [Race]) -> Void {
        FileUtil.writeToFile(fileName: zip + ".json", data: races)
    }
    
    static func getRaces(zip: String) async -> [Race] {
        if (FileUtil.checkIfFileExists(fileName: zip + ".json")) {
            return FileUtil.readFile(fileName: zip + ".json", as: [Race].self) ?? []
        }
        else {
            do {
                let races = try await RequestsUtil.getRaces(zipcode: zip)
                DataModel.saveRaces(zip: zip, races: races)
                return races
            } catch {
                print("Error: \(error)")
            }
            
        }
        return []
    }
}
