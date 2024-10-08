//
//  FilterButton.swift
//  BallotBuddy
//
//  Created by Caden on 10/6/24.
//

import SwiftUI
import Foundation

struct FilterButton: View {
    var name: String
    var category: Category
    @EnvironmentObject var user: User
    @EnvironmentObject var controller: FilterButtonController
    
    var body: some View {
        Button(action: {
            controller.selected = self.category
        }) {
            TranslatedText(name)
                .font(.system(size: 18))
                .padding(.horizontal, 15)
                .padding(.vertical, 5)
                .foregroundColor(controller.selected == category ? Color.white : Color(user.settings.getGlobalAccent()))
                .background(controller.selected == category ? Color(user.settings.getGlobalAccent()) : Color.clear)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(user.settings.getGlobalAccent()), lineWidth: 1)
                )
        }
    }
}

class FilterButtonController: ObservableObject {
    @Published var selected: Category = .all
}

enum Category {
    case state
    case federal
    case local
    case all
    
    static func classify(title: String, level: String, category: Category) -> Bool {
        if (category == .all) {
            return true
        }
        if (level == "Local") {
            return .local == category
        }
        if (level == "State") {
            return .state == category
        }
        if (level == "Federal") {
            return .federal == category
        }
        print(level)
        return false
    }
}

#Preview {
    FilterButton(name: "amongus", category: .all)
}
