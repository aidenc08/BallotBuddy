//
//  SettingsObject.swift
//  BallotBuddy
//
//  Created by Aiden Chavda on 9/29/24.
//

import Foundation


class SettingsObject: Codable {
    var theme: Bool
    var contrast: Bool
    
    init(theme: Bool, contrast: Bool) {
        self.theme = theme
        self.contrast = contrast
    }
    
    init() {
        self.theme = false
        self.contrast = false
    }
}
