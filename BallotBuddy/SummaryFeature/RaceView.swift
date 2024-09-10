//
//  RaceView.swift
//  BallotBuddy
//
//  Created by Aiden Chavda on 9/9/24.
//

import SwiftUI

struct RaceView: View {
    @Binding var index: Int
    @Binding var races: [Race]
    var body: some View {
        VStack {
            TabView {
                ForEach(races[index].candidates, id: \.name) { c in
                    CandidateView(candidate: c)
                }
            }
            .tabViewStyle(.page)
        }
        .background(Color(globalBackground))
    }
}

