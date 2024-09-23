//
//  CandidateTab.swift
//  BallotBuddy
//
//  Created by Caden on 9/22/24.
//

import SwiftUI

struct CandidateTab: View {
    var policy: Policy
    @State var selected: Bool
    
    var body: some View {
        Button(action: {
            selected = !selected
            // unselect other items as well
        }) {
            Text(policy.category)
                .foregroundStyle(selected ? Color(globalAccent) : Color(globalTextColor))
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .cornerRadius(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(selected ? Color(globalAccent) : Color(globalTextColorDark), lineWidth: 1)
                )
        }
    }
}
