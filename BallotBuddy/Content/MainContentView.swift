//
//  MainContentView.swift
//  BallotBuddy
//
//  Created by Caden on 8/24/24.
//

import SwiftUI

struct MainContentView: View {
    @State private var selectedIndex = 0
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                switch selectedIndex {
                case 0:
                    HomeView()
                case 1:
                    Text("Search")
                case 2:
                    Text("Profile")
                default:
                    HomeView()
                }
            }
            
            // Navigation Bar
            NavigationBar(
                selectedIndex: $selectedIndex,
                items: [
                    NavigationItem(iconName: "house", title: "Home"),
                    NavigationItem(iconName: "magnifyingglass", title: "Search"),
                    NavigationItem(iconName: "pencil.and.list.clipboard", title: "Register"),
                    NavigationItem(iconName: "gearshape", title: "Settings")
                ]
            )
            .background(Color(uiColor: UIColor(hex: "212121")))
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    MainContentView()
}
