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
    var name: String
    var zipcode: String
    var targetLanguage: Locale.Language
    var settings: SettingsObject
    
    init(id: Int, name: String, zipcode: String, targetLanguage: Locale.Language) {
        self.id = id
        self.name = name
        self.zipcode = zipcode
        self.targetLanguage = targetLanguage
        self.settings = SettingsObject()
    }
    
    init() {
        self.id = 0
        self.name = ""
        self.zipcode = ""
        self.targetLanguage = Locale.Language(identifier: "en-US")
        self.settings = SettingsObject()
    }
}
