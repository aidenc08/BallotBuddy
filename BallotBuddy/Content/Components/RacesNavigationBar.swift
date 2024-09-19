//
//  RacesNavigationBar.swift
//  BallotBuddy
//
//  Created by Aiden Chavda on 9/9/24.
//

import SwiftUI

struct RacesNavigationBar: View {
    @Binding var selectedIndex: Int
    let items: [RacesNavigationItem]
    
    var body: some View {
        ScrollView {
            ForEach(items.indices) { index in
                Button(action: {
                    selectedIndex = index
                }) {
                    HStack {
                        Text(items[index].title)
                            .font(.system(size: 15))
                        Spacer()
                    }
                    .padding(.vertical, 5)
                    .padding(.horizontal)
                    .foregroundColor(selectedIndex == index ? Color(uiColor: globalAccent) : Color.gray)
                }
            }
        }
        // .background(Color(uiColor: globalBackgroundAccent)) // Ensure background color fills the padded area
    }
}

struct RacesNavigationItem {
    let title: String
}

