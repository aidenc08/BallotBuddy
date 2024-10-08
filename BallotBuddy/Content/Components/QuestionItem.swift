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
    @EnvironmentObject var user: User
    
    @State private var yesButtonColor: UIColor = UIColor(white: 0, alpha: 0)
    @State private var noButtonColor: UIColor = UIColor(white: 0, alpha: 0)
    
    var body: some View {
        TranslatedText(question)
            .frame(maxWidth: .infinity)
            .multilineTextAlignment(.center)
            .padding()
            .background(Color(uiColor: user.settings.getGlobalAccent()))
            .foregroundColor(.white)
            .cornerRadius(4)
            .font(.system(size: 18))
            .onAppear(perform: setColors)
        VStack {
            Button(action: {
                if yesButtonColor == user.settings.getGlobalAccent() {
                    questionResponses[index] = nil
                    yesButtonColor = user.settings.getGlobalTextColorDark()
                } else {
                    questionResponses[index] = true
                    yesButtonColor = user.settings.getGlobalAccent()
                }
                noButtonColor = user.settings.getGlobalTextColorDark()
                
            }){
                TranslatedText("Yes")
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
                if noButtonColor == user.settings.getGlobalAccent() {
                    questionResponses[index] = nil
                    noButtonColor = user.settings.getGlobalTextColorDark()
                } else {
                    questionResponses[index] = false
                    noButtonColor = user.settings.getGlobalAccent()
                }
                yesButtonColor = user.settings.getGlobalTextColorDark()
            }){
                TranslatedText("No")
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
    
    func setColors() -> Void {
        yesButtonColor = user.settings.getGlobalTextColorDark()
        noButtonColor = user.settings.getGlobalTextColorDark()
    }
}
