//
//  QuestionItem.swift
//  BallotBuddy
//
//  Created by Caden on 9/18/24.
//

import SwiftUI

struct QuestionItem: View {
    var question: String
    var index: Int
    @Binding var questionResponses: [Bool?]
    
    @State private var yesButtonColor: UIColor = globalTextColorDark
    @State private var noButtonColor: UIColor = globalTextColorDark
    
    var body: some View {
        Text(question)
            .frame(maxWidth: .infinity)
            .multilineTextAlignment(.center)
            .padding()
            .background(Color(uiColor: globalAccent))
            .foregroundColor(.white)
            .cornerRadius(4)
            .font(.system(size: 18))
        VStack {
            Button(action: {
                if yesButtonColor == globalAccent {
                    questionResponses[index] = nil
                    yesButtonColor = globalTextColorDark
                } else {
                    questionResponses[index] = true
                    yesButtonColor = globalAccent
                }
                noButtonColor = globalTextColorDark
                
            }){
                Text("Yes")
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                    .foregroundColor(Color(yesButtonColor))
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color(yesButtonColor), lineWidth: 1)
                    )
                    
            }
            Spacer()
                .frame(maxHeight: 20)
            Button(action: {
                if noButtonColor == globalAccent {
                    questionResponses[index] = nil
                    noButtonColor = globalTextColorDark
                } else {
                    questionResponses[index] = false
                    noButtonColor = globalAccent
                }
                yesButtonColor = globalTextColorDark
            }){
                Text("No")
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                    .foregroundColor(Color(noButtonColor))
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color(noButtonColor), lineWidth: 1)
                    )
            }
        }
        .padding(.vertical, 10)
    }
}
