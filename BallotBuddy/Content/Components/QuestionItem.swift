//
//  QuestionItem.swift
//  BallotBuddy
//
//  Created by Caden on 9/18/24.
//

import SwiftUI

struct QuestionItem: View {
    var question: String
    
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
                
            }){
                Text("Yes")
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color(globalTextColorDark), lineWidth: 1)
                    )
                    
            }
            Spacer()
                .frame(maxHeight: 20)
            Button(action: {
                
            }){
                Text("No")
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color(globalTextColorDark), lineWidth: 1)
                    )
            }
        }
        .padding(.vertical, 10)
    }
}

#Preview {
    QuestionItem(question: "asfdasdf")
}
