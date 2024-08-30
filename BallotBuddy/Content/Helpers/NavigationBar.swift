//
//  NavigationBar.swift
//  BallotBuddy
//
//  Created by Caden on 8/24/24.
//

import SwiftUI

struct NavigationBar: View {
    @Binding var selectedIndex: Int
    let items: [NavigationItem]
    
    var body: some View {
        HStack {
            ForEach(items.indices) { index in
                Button(action: {
                    selectedIndex = index
                }) {
                    VStack {
                        Image(systemName: items[index].iconName)
                            .font(.system(size: 24))
                            .padding(.top, 6)
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

struct NavigationItem {
    let iconName: String
    let title: String
}
