//
//  HomeView.swift
//  BallotBuddy
//
//  Created by Caden on 8/24/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var user: User
    @State private var races: [Race] = []
    @State private var zipCode: String = ""
    @State private var loadingScreen: Bool = true
    @State private var selectedIndex: Int = 0
    @State private var spin = false
    @EnvironmentObject var controller: FilterButtonController
    
    var body: some View {
        ZStack {
            if loadingScreen {
                VStack {
                    Image(systemName: "arrow.triangle.2.circlepath")
                        .resizable()
                        .foregroundColor(Color(user.settings.getGlobalAccent()))
                        .frame(width: 80, height: 70)
                        .rotationEffect(.degrees(spin ? 360 : 0))
                        .animation(
                            Animation.linear(duration: 1)
                                .repeatForever(autoreverses: false),
                            value: spin
                        )
                        .onAppear {
                            spin = true
                        }
                }
                .zIndex(9999)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
                .background(Color(user.settings.getGlobalBackground()))
            }
            VStack {
                HStack {}
                    .onAppear(perform: {updateRaces()})
                    .padding(.top, 60)
                if (races.count > 0) {
                    HStack {
                        TranslatedText("Upcoming Elections")
                            .font(.system(size: 18))
                            .foregroundColor(Color(user.settings.getGlobalTextColor()))
                        Spacer()
                    }
                    .padding(.horizontal)
                    Spacer().frame(height: 10)
                    HStack(spacing: 10) {
                        FilterButton(name: "All", category: .all)
                        FilterButton(name: "Local", category: .local )
                        FilterButton(name: "State", category: .state)
                        FilterButton(name: "Federal", category: .federal)
                        Spacer()
                    }
                    .padding(.horizontal)
                    Spacer().frame(height: 10)
                    RacesNavigationBar(selectedIndex: $selectedIndex, items: races)
                    RaceView(index: $selectedIndex, races: $races)
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .background(Color(uiColor: user.settings.getGlobalBackground()))

        }
    }
    
    func updateRaces() {
        Task {
            races = await DataModel.getRaces(zip: user.zipcode)
            loadingScreen = false
        }
    }
    
    func getRaces() -> [Race] {
        return races.filter { Category.classify(title: $0.name, level: $0.level, category: controller.selected) }
    }
}

#Preview {
    let user = User(id: 1, zipcode: "94022", targetLanguage: Locale.Language(identifier: "es-419"))
    HomeView()
        .environmentObject(user)
}
