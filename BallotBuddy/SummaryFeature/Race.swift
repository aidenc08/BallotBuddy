//
//  Race.swift
//  BallotBuddy
//
//  Created by Aiden Chavda on 8/28/24.
//

import Foundation

struct Race: Codable {
    var name: String
    var level: String
    var branch: String?
    var type: String?
    var candidates: [Candidate]
}
