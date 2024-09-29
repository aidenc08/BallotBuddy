//
//  RegisterView.swift
//  BallotBuddy
//
//  Created by Caden on 9/18/24.
//

import SwiftUI

struct RegisterView: View {
    @State private var questionResponses: [Bool?] = [nil, nil, nil, nil]
    
    var body: some View {
        VStack {
            Spacer()
                .frame(maxHeight: 70)
            Text("Lets get started!")
                .font(.system(size: 20))
            ScrollView {
                QuestionItem(question: "Are you a US citizen?", index: 0, questionResponses: $questionResponses)
                QuestionItem(question: "Do you currently live in the US?", index: 1, questionResponses: $questionResponses)
                QuestionItem(question: "Are you 18 years old on or before election day?", index: 2, questionResponses: $questionResponses)
                QuestionItem(question: "Have you filled out a registration form yet?", index: 3, questionResponses: $questionResponses)
                Button(action: {
                    print(questionResponses)
                }){
                    Text("Next")
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        .background(Color(globalAccent))
                        .foregroundColor(Color(globalTextColor))
                        .cornerRadius(5)
                }
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
