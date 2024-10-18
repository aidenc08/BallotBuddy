//
//  RegisterView.swift
//  BallotBuddy
//
//  Created by Caden on 9/18/24.
//

import SwiftUI

struct RegisterView: View {
    @State private var questionResponses: [Bool?] = [nil, nil, nil, nil]
    @State private var showQuiz: Bool = true
    @State private var canVote: Bool = false
    @EnvironmentObject var user: User
    var questions = [
        "You are a US citizen",
        "You currently live in the United States",
        "You are 18 years old on or before election day",
        "You have filled out a registration form"
    ]
    var solutions = [
        "Apply for US citizenship at uscis.gov/citizenship",
        "Move to the United States",
        "Wait until you're 18 on or before the election",
        "Fill out the registration form vote.gov/register"
    ]
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                    .frame(maxHeight: 70)
                HStack {
                    TranslatedText("Lets get started!")
                    Spacer()
                }
                    .fontWeight(.bold)
                    .font(.system(size: 25))
                    .padding(.horizontal)
                ScrollView {
                    QuestionItem(question: "Are you a US citizen?", index: 0, questionResponses: $questionResponses)
                    QuestionItem(question: "Do you currently live in the US?", index: 1, questionResponses: $questionResponses)
                    QuestionItem(question: "Are you 18 years old on or before election day?", index: 2, questionResponses: $questionResponses)
                    QuestionItem(question: "Have you filled out a registration form yet?", index: 3, questionResponses: $questionResponses)
                    Button(action: {
                        // print(questionResponses)
                        canVote = (questionResponses.allSatisfy { $0 == true }) ? true : false
                        showQuiz = false
                    }){
                        TranslatedText("Next")
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal)
                            .padding(.vertical, 10)
                            .background(Color(user.settings.getGlobalAccent()))
                            .foregroundColor(Color.white)
                            .cornerRadius(5)
                    }
                }
                .padding()
            }
            .opacity(showQuiz ? 1 : 0)
            // .opacity(0)
            
            // fail
            VStack {
                HStack {
                    TranslatedText("You are ").translatedTextView()
                    + TranslatedText("not eligible").translatedTextView()
                        .foregroundColor(Color(user.settings.getGlobalAccent()))
                    + TranslatedText(" to vote").translatedTextView()
                }
                .font(.system(size: 30))
                Spacer().frame(height: 20)
                ForEach(0..<questions.count, id: \.self) { i in
                    HStack {
                        Image(systemName: questionResponses[i] ?? false ? "checkmark.square.fill" : "xmark.app.fill")
                            .foregroundColor(Color(questionResponses[i] ?? false ? user.settings.getGlobalTextColor() : user.settings.getGlobalAccent()))
                        TranslatedText(questions[i])
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                }
                Spacer().frame(height: 20)
                TranslatedText("How to vote?")
                    .font(.system(size: 30))
                Spacer().frame(height: 20)
                VStack {
                    ForEach(0..<questions.count, id: \.self) { i in
                        renderIfFalse(condition: questionResponses[i] ?? false, solution: solutions[i])
                    }
                }
            }
            .foregroundColor(Color(user.settings.getGlobalTextColor()))
            .font(.system(size: 20))
            .opacity(!showQuiz && !canVote ? 1 : 0)
            //.opacity(1)
            
            // pass
            VStack {
                HStack {
                    TranslatedText("You are ").translatedTextView()
                    + TranslatedText("eligible").translatedTextView()
                        .foregroundColor(Color(user.settings.getGlobalAccent()))
                    + TranslatedText(" to vote").translatedTextView()
                }
                .font(.system(size: 30))
                Spacer().frame(height: 20)
                TranslatedText("Check your state's voter registration page to see next steps:")
                VStack {
                    HStack {
                        Link(destination: URL(string: "https://vote.gov/register")!, label: {
                            TranslatedText("Registration Page")
                                .underline()
                        })
                        .underline(true)
                        .foregroundColor(Color(user.settings.getGlobalAccent()))
                        Spacer()
                    }
                    HStack {
                        Link(destination: URL(string: "https://www.nass.org/can-I-vote/voter-registration-statusr")!, label: {
                            TranslatedText("Registration Status")
                                .underline()
                        })
                            .underline(true)
                            .foregroundColor(Color(user.settings.getGlobalAccent()))
                        Spacer()
                    }
                    HStack {
                        Link(destination: URL(string: "https://www.nass.org/can-I-vote")!, label: {
                            TranslatedText("Voting Information")
                                .underline()
                        })
                            .underline(true)
                            .foregroundColor(Color(user.settings.getGlobalAccent()))
                        Spacer()
                    }
                }
                .padding(.horizontal, 15)
            }
            .padding(.horizontal, 20)
            .foregroundColor(Color(user.settings.getGlobalTextColor()))
            .font(.system(size: 20))
            .opacity(!showQuiz && canVote ? 1 : 0)
            // .opacity(1)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .background(Color(uiColor: user.settings.getGlobalBackground()))
        .foregroundColor(Color(user.settings.getGlobalTextColor()))
    }
    
    func renderIfFalse(condition: Bool, solution: String) -> some View {
        HStack {
            if !condition {
                TranslatedText(solution)
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                Spacer()
            }
        }
            .padding(.horizontal)
    }
}

#Preview {
    RegisterView()
}
