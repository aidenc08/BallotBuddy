//
//  RegisterView.swift
//  BallotBuddy
//
//  Created by Caden on 9/18/24.
//

import SwiftUI

struct RegisterView: View {
    var body: some View {
        VStack {
            Spacer()
                .frame(maxHeight: 70)
            Text("Lets get started!")
                .font(.system(size: 18))
            ScrollView {
                QuestionItem(question: "Are you a US citizen?")
                QuestionItem(question: "Do you currently live in the US?")
                QuestionItem(question: "Are you 18 years old on or before election day?")
                QuestionItem(question: "Have you filled out a registration form yet?")
            }
            .padding()

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .background(Color(uiColor: globalBackground))
        .foregroundColor(Color(globalTextColor))
    }
}

#Preview {
    RegisterView()
}
