//
//  User.swift
//  BallotBuddy
//
//  Created by Aiden Chavda on 8/22/24.
//

import Foundation

class User: Codable, Identifiable, ObservableObject {
    static func == (lhs: User, rhs: User) -> Bool {
        return (lhs.id == rhs.id)
    }
    
    var id: Int
    var zipcode: String
    var targetLanguage: Locale.Language
    var settings: SettingsObject
    
    init(id: Int, zipcode: String, targetLanguage: Locale.Language) {
        self.id = id
        self.zipcode = zipcode
        self.targetLanguage = targetLanguage
        self.settings = SettingsObject()
    }
    
    init() {
        self.id = 0
        self.zipcode = "94022"
        self.targetLanguage = Locale.Language(identifier: "en-US")
        self.settings = SettingsObject()
    }
    
    init(id: Int, zipcode: String, targetLanguage: Locale.Language, settings: SettingsObject) {
        self.id = id
        self.zipcode = zipcode
        self.targetLanguage = targetLanguage
        self.settings = settings
    }
    
    
    func checkValidZipCode(zip: String) async -> Bool {
        return await DataModel.checkValidZipCode(zip: zip)
    }
}
