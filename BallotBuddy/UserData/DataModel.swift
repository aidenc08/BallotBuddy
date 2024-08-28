//
//  DataModel.swift
//  BallotBuddy
//
//  Created by Aiden Chavda on 8/27/24.
//

import Foundation

struct DataModel {
    let util = FileUtil()
    let userDataFileName = "_user"
    
    func getUser() -> User? {
        if (util.checkIfFileExists(fileName: userDataFileName)) {
            let user = util.readFile(fileName: userDataFileName)
            return user
        }
        else {
            return nil
        }
    }
    
    func saveUser(u: User) {
        util.writeToFile(fileName: userDataFileName, data: u)
    }
    
    func deleteUser() {
        util.deleteFile(fileName: userDataFileName)
    }
    
    func getMailInRegistrationItems() -> [RegistrationItem] {
        return util.loadJSON("mail.json", as: [RegistrationItem].self)
    }
    
    func getInPersonRegistrationItems() -> [RegistrationItem] {
        return util.loadJSON("in_person.json", as: [RegistrationItem].self)
    }
}
