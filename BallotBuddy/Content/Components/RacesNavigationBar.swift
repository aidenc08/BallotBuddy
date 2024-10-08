//
//  RacesNavigationBar.swift
//  BallotBuddy
//
//  Created by Aiden Chavda on 9/9/24.
//

import SwiftUI

struct RacesNavigationBar: View {
    @Binding var selectedIndex: Int
    @EnvironmentObject var user: User
    @EnvironmentObject var controller: FilterButtonController
    let items: [Race]
    
    var body: some View {
        ScrollView {
            ForEach(Array(items.enumerated()), id: \.offset) { index, i in
                if (Category.classify(title: i.name, level: i.level, category: controller.selected)) {
                    Button(action: {
                        selectedIndex = index
                    }) {
                        HStack {
                            //Text(items[index].type)
                            TranslatedText(i.name)
                                .font(.system(size: 15))
                                .frame(maxWidth: .infinity, alignment: .center)
                            Spacer()
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 10)
                        .background(selectedIndex == index ? Color(user.settings.getGlobalAccent()) : Color.clear)
                        .cornerRadius(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color(selectedIndex == index ? user.settings.getGlobalAccent() : user.settings.getGlobalTextColorDark()), lineWidth: 1)
                        )
                        .foregroundColor(selectedIndex == index ? Color.white : Color(user.settings.getGlobalTextColorDark()))
                    }
                }
            }
        }
        .padding(.horizontal)
        // .background(Color(uiColor: globalBackgroundAccent)) // Ensure background color fills the padded area
    }
}

