//
//  CandidateView.swift
//  BallotBuddy
//
//  Created by Aiden Chavda on 9/9/24.
//

import SwiftUI

struct CandidateView: View {
    @State private var showDisclaimer = false
    @ObservedObject var candidate: Candidate
    let columns = [GridItem(.adaptive(minimum: 100))]
    @ObservedObject var controller: CandidateTabController
    @EnvironmentObject var user: User
    let thumbnail: String
    let campaign_url: String
    @State private var noPolicies = false
    
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
                        .foregroundStyle(Color(user.settings.getGlobalTextColor()))
                        .font(.system(size: 20))
                    Link(campaign_url.replacingOccurrences(of: "www.", with: "").replacingOccurrences(of: "https://", with: ""), destination: (URL(string: campaign_url) ?? URL("https://google.com"))!)
                        .foregroundStyle(Color(user.settings.getGlobalTextColor()))
                        .onAppear(perform: updateCandidate)
                        .padding(.horizontal, 5)
                        .padding(.vertical, 2)
                        .cornerRadius(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color(user.settings.getGlobalTextColorDark()), lineWidth: 1)
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
                                TranslatedText("Summarized with AI")
                                    .foregroundStyle(Color(user.settings.getGlobalTextColorDark()))
                                    .onTapGesture {
                                        showDisclaimer.toggle()
                                    }
                                Spacer()
                            }
                            .sheet(isPresented: $showDisclaimer) {
                                DisclaimerView(url: formatURL(url: p.url))
                                    .presentationDetents([.height(200)])
                            }
                            TranslatedText(p.summary)
                                .foregroundStyle(Color(user.settings.getGlobalTextColor()))
                        }
                        .padding(.horizontal)
                    }
                    Spacer()
                }
                else {
                    TranslatedText("Could not find any policies").foregroundStyle(Color(user.settings.getGlobalTextColor()))
                }
            }.background(Color(uiColor: user.settings.getGlobalBackground()))
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
                noPolicies = true
            }
            else {
                controller.policy = candidate.policies![0]
            }
        }
    }
}

struct DisclaimerView: View {
    var url: String
    @EnvironmentObject var user: User
    var body: some View {
        VStack {
            HStack {
                Image("icon_ai")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                TranslatedText("Disclaimer")
                    .font(.system(size: 20))
                Spacer()
            }
            TranslatedText("Summaries are generated using Google's Gemini-1.5-flash model. The target webpage being summarized is '\(url)'. Note that there may be inaccuracies in the summaries generated by AI.")
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .foregroundColor(Color(user.settings.getGlobalTextColor()))
        .padding()
        .background(Color(user.settings.getGlobalBackgroundAccent()))
    }
}
