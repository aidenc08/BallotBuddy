//
//  SettingsObject.swift
//  BallotBuddy
//
//  Created by Aiden Chavda on 9/29/24.
//

import Foundation
import SwiftUI


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
    
    func getGlobalBackground() -> UIColor {
        return self.theme ? UIColor(hex: "121212") : UIColor(hex: "ffffff")
    }

    func getGlobalBackgroundAccent() -> UIColor {
        return self.theme ? UIColor(hex: "212121") : UIColor(hex: "ebebeb")
    }

    func getGlobalTextColor() -> UIColor {
        return self.theme ? UIColor(hex: "ebebeb") : UIColor(hex: "363636")
    }

    func getGlobalAccent() -> UIColor {
        return UIColor(hex: "EA6461")
    }

    func getGlobalTextColorDark() -> UIColor {
        return self.theme ? UIColor(hex: "adadad") : UIColor(hex: "595959")
    }

}
