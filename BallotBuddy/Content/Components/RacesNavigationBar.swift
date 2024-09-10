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
        HStack {
            ForEach(items.indices) { index in
                Button(action: {
                    selectedIndex = index
                }) {
                    VStack {
                        Text(items[index].title)
                            .font(.caption)
                    }
                    .foregroundColor(selectedIndex == index ? Color(uiColor: UIColor(hex: "EA6461")) : Color.gray)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .background(Color(uiColor: globalBackgroundAccent)) // Ensure background color fills the padded area
        .padding(.horizontal) // Apply horizontal padding to the HStack
        .padding(.bottom, 20) // Set specific bottom padding height
        .padding(.top, 10) // Set specific top padding height
    }
}

struct RacesNavigationItem {
    let title: String
}

