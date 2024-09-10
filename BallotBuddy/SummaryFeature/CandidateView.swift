//
//  CandidateView.swift
//  BallotBuddy
//
//  Created by Aiden Chavda on 9/9/24.
//

import SwiftUI

struct CandidateView: View {
    public var candidate: Candidate
    var body: some View {
        Text(candidate.name).foregroundStyle(.white)
    }
}


