//
//  CandidateTab.swift
//  BallotBuddy
//
//  Created by Caden on 9/22/24.
//

import SwiftUI

struct CandidateTab: View {
    var policy: Policy
    @ObservedObject var controller: CandidateTabController
    
    var body: some View {
        Button(action: {
            controller.policy = self.policy
            // unselect other items as well
        }) {
            Text(policy.category)
                .foregroundStyle(controller.policy == self.policy ? Color(globalAccent) : Color(globalTextColor))
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .cornerRadius(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(controller.policy == self.policy ? Color(globalAccent) : Color(globalTextColorDark), lineWidth: 1)
                )
        }
    }
}
