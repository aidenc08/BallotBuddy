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
    @ObservedObject var controller: CandidateTabController
    
    init(candidate: Candidate) {
        self.candidate = candidate
        self.controller = CandidateTabController(policy: nil)

    }
    
    var body: some View {
        VStack {
            Text(candidate.name).foregroundStyle(.white).onAppear(perform: updateCandidate)
            if let policies = candidate.policies {
                ScrollView(.horizontal) {
                    HStack(spacing: 10) {
                        ForEach(Array(policies.enumerated()), id: \.element.summary) { index, policy in
                            CandidateTab(policy: policy, controller: controller)
                        }
                    }
                    .padding(.horizontal)
                }
                // access whatever policy you want using p
                if let p = controller.policy {
                    Text(p.summary).foregroundStyle(.white)
                }
                Spacer()
            }
            else {
                // handle case when there are no policies (couldn't fetch, etc.)
            }
        }.background(Color(uiColor: globalBackground))
    }
    
    func updateCandidate() -> Void {
        Task {
            await candidate.getPolicies()
            if (candidate.policies == nil || candidate.policies?.count == 0) {
                controller.policy = nil
            }
            else {
                controller.policy = candidate.policies![0]
            }
        }
    }
}


