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
                    .foregroundColor(Color(globalTextColorDark))
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color(globalTextColorDark), lineWidth: 1)
                    )
            }
            .onAppear(perform: {
                updateRaces()
                
            })
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            if (races.count > 0) {
                HStack {
                    Text("Upcoming Elections")
                        .font(.system(size: 18))
                        .foregroundColor(Color(globalTextColor))
                    Spacer()
                }
                .padding(.horizontal)
                RacesNavigationBar(selectedIndex: $selectedIndex, items: races.map{RacesNavigationItem(title: $0.name)})
                RaceView(index: $selectedIndex, races: $races)
            }
            

            /*
            ZStack(alignment: .top) { // stupid shit to bypass not being able to set the fucking padding at the top of the fucking list
                VStack {
                    HStack {
                        Text("Loading...")
                            .foregroundColor(Color(globalTextColor))
                            .font(.system(size: 18))
                        Spacer()
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 30)
                .zIndex(3)
                .frame(maxWidth: .infinity, alignment: .top)
                .opacity(loadingScreen ? 1 : 0)
                List {
                    ForEach(races, id: \.self.name) { race in
                        Text(race.name)
                            .listRowBackground(Color(uiColor: globalBackgroundAccent))
                            .foregroundColor(Color(globalTextColor))
                    }
                }
                .background(Color(globalBackground))
                .onAppear(perform: {
                    updateRaces()
                    
                })
                .scrollContentBackground(.hidden)
                .zIndex(2)
                
                VStack {
                    HStack {
                        Text("Upcoming Elections")
                            .foregroundColor(Color(globalTextColor))
                            .font(.system(size: 20))
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 0)
                    .background(Color(globalBackground))
                }
                .zIndex(3)
                .frame(maxWidth: .infinity, alignment: .top)
            }
            */
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .background(Color(uiColor: globalBackground))
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
