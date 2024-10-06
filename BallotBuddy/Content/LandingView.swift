//
//  LandingView.swift
//  BallotBuddy
//
//  Created by Caden on 10/6/24.
//

import SwiftUI

struct LandingView: View {
    // @Binding var onLanding: Bool
    @State private var zipCode: String = ""
    
    var body: some View {
        ZStack {
            /*Image("icon_ballot")
                .resizable()
                .renderingMode(.template)
                .foregroundColor(Color(globalAccent))
                .frame(width: 130, height: 130)
                .padding()
            */
            VStack {
                Spacer()
                HStack {
                    Text("Welcome to ")
                    + Text("Ballot Buddy")
                        .foregroundColor(Color(globalAccent))
                }
                .font(.title2)
                .fontWeight(.bold)
                Spacer().frame(height: 20)
                Text("Ballot Buddy as an app you can use to get all kinds of different information about elections and voting")
                    .padding(.horizontal)
                Spacer().frame(height: 20)
                VStack {
                    TextField("Zip...", text: $zipCode)
                        .font(.system(size: 20))
                        .padding(10)
                        .foregroundColor(Color(globalTextColorDark))
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color(globalTextColorDark), lineWidth: 1)
                        )
                }
                .padding(.horizontal, 20)
                Spacer().frame(height: 20)
                HStack {
                    Button(action: {}){
                        Text("Continue")
                            .padding(.horizontal)
                            .padding(.vertical, 10)
                            .foregroundColor(Color(globalTextColor))
                            .background(Color(globalAccent))
                            .cornerRadius(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color(globalAccent), lineWidth: 1)
                            )
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
            }
            .padding(.bottom, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .background(Color(uiColor: globalBackground))
        .foregroundColor(Color(globalTextColor))
    }
}

#Preview {
    LandingView()
}
