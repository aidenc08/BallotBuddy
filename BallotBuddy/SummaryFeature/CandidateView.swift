//
//  CandidateView.swift
//  BallotBuddy
//
//  Created by Aiden Chavda on 9/9/24.
//

import SwiftUI

struct CandidateView: View {
    @ObservedObject var candidate: Candidate
    let columns = [GridItem(.adaptive(minimum: 100))]
    
    var body: some View {
        VStack {
            Text(candidate.name).foregroundStyle(.white).onAppear(perform: updateCandidate)
            if (candidate.policies != nil) {
                ScrollView(.horizontal) {
                    HStack(spacing: 10) {
                        ForEach(candidate.policies!, id: \.self.summary) { p in
                            CandidateTab(policy: p, selected: false)
                        }
                    }
                    .padding(.horizontal)
                    
                }
                Spacer()
            }
        }.background(Color(uiColor: globalBackground))
    }
    
    func updateCandidate() -> Void {
        candidate.getPolicies()
    }
}


