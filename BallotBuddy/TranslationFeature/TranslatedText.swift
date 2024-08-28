//
//  TranslatedText.swift
//  BallotBuddy
//
//  Created by Aiden Chavda on 8/22/24.
//

import SwiftUI
import Foundation
import Translation

struct TranslatedText: View {
    @EnvironmentObject var user: User
    var sourceText: String
    let sourceLanguage = Locale.Language(identifier: "en-US")
    init(_ sourceText:String){
        self.sourceText = sourceText
    }
    @State private var targetText: String?
    var body: some View {
        if #available(iOS 18.0, *) {
            Text(targetText ?? sourceText)
            /*
                .translationTask(
                    source: sourceLanguage,
                    target: user.targetLanguage
                ) { session in
                    do {
                        let response = try await session.translate(sourceText)
                        targetText = response.targetText
                    } catch {
                        // Handle error.
                    }
                }
             */
        } else {
            Text(sourceText)
        }
    }
}

#Preview {
    TranslatedText("Hello").environmentObject(User(id: 1, name: "GAA", zipcode: "94016", targetLanguage: Locale.Language(identifier: "es-419")))
}
