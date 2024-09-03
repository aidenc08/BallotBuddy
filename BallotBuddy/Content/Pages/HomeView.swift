//
//  HomeView.swift
//  BallotBuddy
//
//  Created by Caden on 8/24/24.
//

import SwiftUI

struct HomeView: View {
    @State private var zipCode: String = ""

    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("Enter your zip code")
                        .foregroundColor(Color(globalTextColor))
                        .font(.system(size: 18))
                }
                .padding(.top, 50)
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            HStack {
                TextField("Zip...", text: $zipCode)
                    .padding(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color(globalBackgroundAccent), lineWidth: 1)
                    )
            }
            .padding(.horizontal, 20)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .background(Color(uiColor: globalBackground))
    }
}

#Preview {
    HomeView()
}
