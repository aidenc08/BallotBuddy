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
                Text("Lets get started!")
                    .font(.system(size: 20))
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
                        Text("Next")
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal)
                            .padding(.vertical, 10)
                            .background(Color(globalAccent))
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
                    Text("You are ")
                    + Text("not eligible")
                        .foregroundColor(Color(globalAccent))
                    + Text(" to vote")
                }
                .font(.system(size: 30))
                Spacer().frame(height: 20)
                ForEach(0..<questions.count, id: \.self) { i in
                    HStack {
                        Image(systemName: questionResponses[i] ?? false ? "checkmark.square.fill" : "xmark.app.fill")
                            .foregroundColor(Color(questionResponses[i] ?? false ? globalTextColor : globalAccent))
                        Text(questions[i])
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                }
                Spacer().frame(height: 20)
                Text("How to vote?")
                    .font(.system(size: 30))
                Spacer().frame(height: 20)
                VStack {
                    ForEach(0..<questions.count, id: \.self) { i in
                        renderIfFalse(condition: questionResponses[i] ?? false, solution: solutions[i])
                    }
                }
            }
            .foregroundColor(Color(globalTextColor))
            .font(.system(size: 20))
            .opacity(!showQuiz && !canVote ? 1 : 0)
            //.opacity(1)
            
            // pass
            VStack {
                HStack {
                    Text("You are ")
                    + Text("eligible")
                        .foregroundColor(Color(globalAccent))
                    + Text(" to vote")
                }
                .font(.system(size: 30))
                Spacer().frame(height: 20)
                Text("Check your state's voter registration page to see next steps:")
                VStack {
                    HStack {
                        Link(destination: URL(string: "https://vote.gov/register")!, label: {
                            Text("Registration Page")
                                .underline()
                        })
                        .underline(true)
                        .foregroundColor(Color(globalAccent))
                        Spacer()
                    }
                    HStack {
                        Link(destination: URL(string: "https://www.nass.org/can-I-vote/voter-registration-statusr")!, label: {
                            Text("Registration Status")
                                .underline()
                        })
                            .underline(true)
                            .foregroundColor(Color(globalAccent))
                        Spacer()
                    }
                    HStack {
                        Link(destination: URL(string: "https://www.nass.org/can-I-vote")!, label: {
                            Text("Voting Information")
                                .underline()
                        })
                            .underline(true)
                            .foregroundColor(Color(globalAccent))
                        Spacer()
                    }
                }
                .padding(.horizontal, 15)
            }
            .padding(.horizontal, 20)
            .foregroundColor(Color(globalTextColor))
            .font(.system(size: 20))
            .opacity(!showQuiz && canVote ? 1 : 0)
            // .opacity(1)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .background(Color(uiColor: globalBackground))
        .foregroundColor(Color(globalTextColor))
    }
    
    func renderIfFalse(condition: Bool, solution: String) -> some View {
        HStack {
            if !condition {
                Text(solution)
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
