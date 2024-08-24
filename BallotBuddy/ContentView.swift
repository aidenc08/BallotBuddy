//
//  ContentView.swift
//  BallotBuddy
//
//  Created by Aiden Chavda on 8/17/24.
//

import SwiftUI

struct ContentView: View {
    let user: User = User(id: 1, name: "GAA", zipcode: 1, targetLanguage: Locale.Language(identifier: "es-419"))
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            TranslatedText("Hello, world!")
        }.environmentObject(user)
        .padding()
    }
}

#Preview {
    ContentView()
}
