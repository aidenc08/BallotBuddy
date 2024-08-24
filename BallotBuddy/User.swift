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
    var zipcode: Int
    var targetLanguage: Locale.Language
    
    init(id: Int, name: String, zipcode: Int, targetLanguage: Locale.Language) {
        self.id = id
        self.name = name
        self.zipcode = zipcode
        self.targetLanguage = targetLanguage
    }
}
