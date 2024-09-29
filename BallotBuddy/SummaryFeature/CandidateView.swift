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
    let thumbnail: String
    let campaign_url: String
    
    init(candidate: Candidate) {
        self.candidate = candidate
        self.controller = CandidateTabController(policy: nil)
        self.thumbnail = candidate.thumbnail ?? ""
        var temp = candidate.campaign_url ?? ""
        if temp.hasSuffix("/") {temp = String(temp.dropLast())}
        self.campaign_url = temp
    }
    
    var body: some View {
        VStack {
            HStack {
                AsyncImage(url: URL(string: thumbnail)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())
                } placeholder: {
                    ProgressView()
                }
                Spacer().frame(width: 10)
                Text(candidate.name)
                    .foregroundStyle(Color(globalTextColor))
                    .font(.system(size: 20))
                Link(campaign_url.replacingOccurrences(of: "www.", with: "").replacingOccurrences(of: "https://", with: ""), destination: URL(string: campaign_url)!)
                    .foregroundStyle(Color(globalTextColor))
                    .onAppear(perform: updateCandidate)
                    .padding(.horizontal, 5)
                    .padding(.vertical, 2)
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color(globalTextColorDark), lineWidth: 1)
                    )
            }
            if let policies = candidate.policies {
                ScrollView(.horizontal) {
                    HStack(spacing: 10) {
                        ForEach(Array(policies.enumerated()), id: \.element.summary) { index, policy in
                            CandidateTab(policy: policy, controller: controller)
                        }
                    }
                }
                .padding(.horizontal)
                // access whatever policy you want using p
                if let p = controller.policy {
                    VStack {
                        Spacer().frame(height: 10)
                        HStack {
                            Image("icon_ai")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                            Text("Summarized with AI from \(formatURL(url: p.url))")
                                .foregroundStyle(Color(globalTextColorDark))
                            Spacer()
                        }
                        Text(p.summary)
                            .foregroundStyle(Color(globalTextColor))
                    }
                    .padding(.horizontal)
                }
                Spacer()
            }
            else {
                // handle case when there are no policies (couldn't fetch, etc.)
            }
        }.background(Color(uiColor: globalBackground))
    }
    
    func formatURL(url: String?) -> String {
        var u = url ?? "[Not Found]"
        if u.hasSuffix("/") {u = String(u.dropLast())}
        u = u.replacingOccurrences(of: "www.", with: "").replacingOccurrences(of: "https://", with: "")
        return u
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


