//
//  CandidateView.swift
//  BallotBuddy
//
//  Created by Aiden Chavda on 9/9/24.
//

import SwiftUI

struct CandidateView: View {
    @ObservedObject var candidate: Candidate
    var body: some View {
        VStack {
            Text(candidate.name).foregroundStyle(.white).onAppear(perform: updateCandidate)
            if (candidate.policies != nil) {
                List {
                    ForEach(candidate.policies!, id: \.self.summary) { p in
                        HStack {
                            Text(p.category).foregroundStyle(Color(globalTextColor))
                            Text(p.summary).foregroundStyle(Color(globalTextColor))
                        }
                    }  
                    
                }
            }
        }.background(Color(uiColor: globalBackground))
    }
    
    func updateCandidate() -> Void {
        candidate.getPolicies()
    }
}


