//
//  FilterButton.swift
//  BallotBuddy
//
//  Created by Caden on 10/6/24.
//

import SwiftUI

struct FilterButton: View {
    var name: String
    var selected: Bool
    
    var body: some View {
        Button(action: {
            
        }) {
            Text(name)
                .font(.system(size: 18))
                .padding(.horizontal, 15)
                .padding(.vertical, 5)
                .foregroundColor(selected ? Color.white : Color(globalAccent))
                .background(selected ? Color(globalAccent) : Color.clear)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(globalAccent), lineWidth: 1)
                )
        }
    }
}

#Preview {
    FilterButton(name: "amongus", selected: false)
}
