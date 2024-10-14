//
//  LandingView.swift
//  BallotBuddy
//
//  Created by Caden on 10/6/24.
//

import SwiftUI
import Foundation
import Translation // Ensure to import the Translation framework

@available(iOS 18.0, *)
func fetchSupportedLanguages() async throws -> [Locale.Language] {
    let languageAvailability = LanguageAvailability()
    let supportedLanguages = try await languageAvailability.supportedLanguages
    return supportedLanguages
}

@available(iOS 18.0, *)
struct LandingView: View {
    @State var onLanding: Bool
    @State private var zipCode: String = ""
    @State private var user: User
    @State private var currentPage = 0
    @State private var validZip: Bool = true;
    @State private var selectedOption: Locale.Language = Locale.Language(identifier: "en-US")
    let images = ["s1", "s2", "s3", "s4"]
    
    init() {
        let user = DataModel.getUser()
        if (user == nil) {
            self.onLanding = true
            self.user = User()
        }
        else {
            self.onLanding = true
            self.user = user!
        }
    }
    
    var body: some View {
        if (onLanding) {
            ZStack {
                /*Image("icon_ballot")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(Color(globalAccent))
                    .frame(width: 130, height: 130)
                    .padding()
                */
                VStack {
                    Spacer().frame(height: 280)
                    TabView(selection: $currentPage) {
                        ForEach(0..<images.count, id: \.self) { index in
                            Image(images[index])
                                .resizable()
                                .scaledToFill()
                                .tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    .frame(height: 200)
                    .cornerRadius(10)
                    .padding([.leading, .trailing], 20)
                    Spacer()
                    .onReceive(timer) { _ in
                        withAnimation {
                            currentPage = (currentPage + 1) % images.count
                        }
                    }
                }
                VStack {
                    Spacer()
                    HStack {
                        Text("Welcome to ")
                        + Text("Ballot Buddy")
                            .foregroundColor(Color(user.settings.getGlobalAccent()))
                    }
                    .font(.title2)
                    .fontWeight(.bold)
                    Spacer().frame(height: 20)
                    Text("Ballot Buddy is an app you can use to get all kinds of different information about elections and voting")
                        .padding(.horizontal)
                    Spacer().frame(height: 20)
                    VStack {
                        TextField("Zip...", text: $zipCode)
                            .font(.system(size: 20))
                            .padding(10)
                            .foregroundColor(Color(user.settings.getGlobalTextColorDark()))
                            .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(Color(validZip ? user.settings.getGlobalTextColorDark() : user.settings.getGlobalAccent()), lineWidth: 1)
                            )
                    }
                    .padding(.horizontal, 20)
                    Spacer().frame(height: 10)
                    DropdownMenuView(selectedOption: $selectedOption, user: user)
                    Spacer().frame(height: 10)
                    HStack {
                        Button(action: {
                           save()
                        }){
                            Text("Continue")
                                .padding(.horizontal)
                                .padding(.vertical, 10)
                                .foregroundColor(Color.white)
                                .background(Color(user.settings.getGlobalAccent()))
                                .cornerRadius(5)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color(user.settings.getGlobalAccent()), lineWidth: 1)
                                )
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.bottom, 40)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .background(Color(uiColor: user.settings.getGlobalBackground()))
            .foregroundColor(Color(user.settings.getGlobalTextColor()))
        }
        else {
            MainContentView(onLanding: $onLanding)
                .environmentObject(user)
                .onChange(of: onLanding, checkUserExistence)
        }
    }
    func checkUserExistence(original: Bool, new: Bool) -> Void {
        if (new == false) {
            return
        }
        let u = DataModel.getUser()
        if (u == nil) {
            self.onLanding = true
            self.user = User()
        }
        else {
            self.onLanding = false
            self.user = u!
        }
    }
    
    func save() -> Void {
        Task {
            self.validZip = (await user.checkValidZipCode(zip: zipCode))
            if (validZip) {
                user.zipcode = self.zipCode
                user.targetLanguage = selectedOption
                DataModel.saveUser(u: user)
                onLanding = false
            }
        }
        
    }
    
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
}

extension Locale.Language {
    var localizedName: String {
        return Locale.current.localizedString(forLanguageCode: languageCode?.identifier ?? "") ?? "Unknown Language"
    }
}

@available(iOS 18.0, *)
struct DropdownMenuView: View {
    @Binding var selectedOption: Locale.Language
    @State private var showMenu = false
    @State var user: User
    @State private var options: [Locale.Language] = []
    
    func loadLanguages() {
        print("gh")
        Task {
            do {
                options = try await fetchSupportedLanguages()
            } catch {
                print("Failed to fetch languages: \(error)")
            }
        }
    }

    var body: some View {
        VStack {
            Button(action: {
                showMenu.toggle()
            }) {
                HStack {
                    Text(selectedOption.localizedName)
                        .foregroundColor(Color(user.settings.getGlobalTextColor()))
                    Spacer()
                    Image(systemName: showMenu ? "chevron.up" : "chevron.down")
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color(user.settings.getGlobalTextColorDark()), lineWidth: 1)
                )
            }

            if showMenu {
                ScrollView {
                    ForEach(options, id: \.self) { option in
                        Button(action: {
                            selectedOption = option
                            showMenu = false
                        }) {
                            Text(option.localizedName)
                                .foregroundColor(Color(user.settings.getGlobalTextColor()))
                                .padding(10)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(Color(user.settings.getGlobalTextColorDark()), lineWidth: 1)
                                )
                        }
                    }
                }
                .frame(maxHeight: 200)
            }
        }
        .padding(20)
        .onAppear {
            loadLanguages()
        }
    }
}

@available(iOS 18.0, *)
#Preview {
    LandingView()
}
