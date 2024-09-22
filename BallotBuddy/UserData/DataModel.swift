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
    
    static func savePolicies(url: String, policies: [Policy]) -> Void {
        FileUtil.writeToFile(fileName: url + ".json", data: policies)
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
    
    static func getPolicies(url: String) async -> [Policy] {
        let firstSubstringToRemove = "https://"
        let secondSubstringToRemove = "www."
        let thirdSubstringToRemove = ".com/"
        let fourthSubstringToRemove = ".com"
        let modifiedUrl = url.replacingOccurrences(of: firstSubstringToRemove, with: "").replacingOccurrences(of: secondSubstringToRemove, with: "").replacingOccurrences(of: thirdSubstringToRemove, with: "").replacingOccurrences(of: fourthSubstringToRemove, with: "")
        if (FileUtil.checkIfFileExists(fileName: modifiedUrl + ".json")) {
            return FileUtil.readFile(fileName: modifiedUrl + ".json", as: [Policy].self) ?? []
        }
        else {
            do {
                let data = try await RequestsUtil.getPolicies(url: url)
                if (data.count == 0) {
                    return []
                }
                var policies: [Policy] = []
                for p in data {
                    for policy in p.summary {
                        policies.append(policy)
                    }
                }
                DataModel.savePolicies(url: modifiedUrl, policies: policies)
                return policies
            } catch {
                print(url)
                print("Error: \(error)")
            }
        }
        return []
    }
}
