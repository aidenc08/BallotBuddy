//
//  ElectionsView.swift
//  BallotBuddy
//
//  Created by Aiden Chavda on 8/28/24.
//

import SwiftUI

struct ElectionsView: View {
    @EnvironmentObject var user: User
    @State private var races: [Race] = []
    var body: some View {
        List {
            ForEach(races, id: \.self.name) { race in
                Text(race.name)
            }
        }
        .onAppear(perform: {
            updateRaces()
        })
    }
    
    func updateRaces() {
        Task {
            do {
                races = try await RequestsUtil.getRaces(zipcode: user.zipcode)
            } catch {
                print("Error: \(error)")
            }
        }
    }
}

#Preview {
    let user = User(id: 1, name: "GAA", zipcode: "94016", targetLanguage: Locale.Language(identifier: "es-419"))
    return ElectionsView()
        .environmentObject(user)
}
