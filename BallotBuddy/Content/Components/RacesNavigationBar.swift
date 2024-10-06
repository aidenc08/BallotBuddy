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
                        //Text(items[index].type)
                        Text(items[index].title)
                            .font(.system(size: 15))
                            .frame(maxWidth: .infinity, alignment: .center)
                        Spacer()
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 10)
                    .background(selectedIndex == index ? Color(globalAccent) : Color.clear)
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color(selectedIndex == index ? globalAccent : globalTextColorDark), lineWidth: 1)
                    )
                    .foregroundColor(selectedIndex == index ? Color.white : Color(globalTextColorDark))
                }
            }
        }
        .padding(.horizontal)
        // .background(Color(uiColor: globalBackgroundAccent)) // Ensure background color fills the padded area
    }
}

struct RacesNavigationItem {
    let title: String
}

