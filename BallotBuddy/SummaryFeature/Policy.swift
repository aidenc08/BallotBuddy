//
//  Policy.swift
//  BallotBuddy
//
//  Created by Aiden Chavda on 9/13/24.
//

import Foundation

class Policy: Codable, Equatable {
    static func == (lhs: Policy, rhs: Policy) -> Bool {
        return lhs.category == rhs.category && lhs.summary == rhs.summary && lhs.url == rhs.url
    }
    
    var category: String
    var summary: String
    var url: String?
    
    init(category: String, summary: String) {
        self.category = category
        self.summary = summary
        self.url = nil
    }
}
