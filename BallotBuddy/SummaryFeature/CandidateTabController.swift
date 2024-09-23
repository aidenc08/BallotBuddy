//
//  CandidateTabController.swift
//  BallotBuddy
//
//  Created by Aiden Chavda on 9/23/24.
//

import Foundation


class CandidateTabController: ObservableObject {
    @Published var policy: Policy?
    
    init(policy: Policy?) {
        self.policy = policy
    }
}
