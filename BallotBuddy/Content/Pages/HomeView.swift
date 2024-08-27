//
//  HomeView.swift
//  BallotBuddy
//
//  Created by Caden on 8/24/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        Text("Home Content")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(uiColor: UIColor(hex: "121212")))
                    .ignoresSafeArea()
    }
}

#Preview {
    HomeView()
}
