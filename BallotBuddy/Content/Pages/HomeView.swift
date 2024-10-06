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
    
    var body: some View {
        ZStack {
            if loadingScreen {
                VStack {
                    Image(systemName: "arrow.triangle.2.circlepath")
                        .resizable()
                        .foregroundColor(Color(globalAccent))
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
                .background(Color(globalBackground))
            }
            VStack {
                HStack {}
                    .onAppear(perform: {updateRaces()})
                    .padding(.top, 60)
                if (races.count > 0) {
                    HStack {
                        Text("Upcoming Elections")
                            .font(.system(size: 18))
                            .foregroundColor(Color(globalTextColor))
                        Spacer()
                    }
                    .padding(.horizontal)
                    Spacer().frame(height: 10)
                    HStack(spacing: 10) {
                        FilterButton(name: "All", selected: true)
                        FilterButton(name: "Local", selected: false)
                        FilterButton(name: "State", selected: false)
                        FilterButton(name: "Federal", selected: false)
                        Spacer()
                    }
                    .padding(.horizontal)
                    Spacer().frame(height: 10)
                    RacesNavigationBar(selectedIndex: $selectedIndex, items: races.map{RacesNavigationItem(title: $0.name)})
                    RaceView(index: $selectedIndex, races: $races)
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .background(Color(uiColor: globalBackground))

        }
    }
    
    func updateRaces() {
        Task {
            races = await DataModel.getRaces(zip: user.zipcode)
            loadingScreen = false
        }
    }
}

#Preview {
    let user = User(id: 1, name: "GAA", zipcode: "94022", targetLanguage: Locale.Language(identifier: "es-419"))
    return HomeView()
        .environmentObject(user)
}
