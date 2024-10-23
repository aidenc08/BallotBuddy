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
    
    init(_ sourceText: String) {
        self.sourceText = sourceText
    }
    
    @State private var targetText: String?
    
    var body: some View {
        if #available(iOS 18.0, *) {
            if (user.targetLanguage != sourceLanguage){
                translatedTextView()
                    .translationTask(
                        source: sourceLanguage,
                        target: user.targetLanguage
                    ) { session in
                        do {
                            let response = try await session.translate(sourceText)
                            targetText = response.targetText
                        } catch {
                            targetText = sourceText
                        }
                    }
            }
            else {
                Text(sourceText)
            }
        } else {
            Text(sourceText)
        }
    }
    
    // Function to return a Text view that can be used for chaining
    func translatedTextView() -> Text {
        Text(targetText ?? sourceText)
    }
}

#Preview {
    TranslatedText("Hello")
        .environmentObject(User(id: 1, zipcode: "94016", targetLanguage: Locale.Language(identifier: "es-419")))
}
