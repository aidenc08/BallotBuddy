//
//  SettingsView.swift
//  BallotBuddy
//
//  Created by Caden on 8/30/24.
//
import SwiftUI

struct SettingsView: View {
    @State private var themeToggle = false
    @State private var contrastToggle = false
    @State private var zipCode: String = ""
    @State private var zipError = false
    @State private var refresh: Bool = false
    @EnvironmentObject var user: User
    @Binding var onLanding: Bool

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    TranslatedText("Settings")
                        .font(.system(size: 30))
                        .frame(maxWidth: .infinity)
                    
                }
                .onAppear(perform: {
                    setSettings()
                    saveData()
                })
                .padding(.top, 70)
                .padding(.bottom, 20)
                .background(Color(uiColor: user.settings.getGlobalBackgroundAccent()))
                .ignoresSafeArea()
                VStack {
                    HStack {
                        TranslatedText("App Settings")
                            .font(.system(size: 20))
                        Spacer()
                    }
                    // app settings
                    VStack {
                        HStack(alignment: .center) {
                            Image(systemName: "paintpalette")
                                .font(.system(size: 24))
                                .padding(.top, 6)
                                .foregroundColor(Color.gray)
                            TranslatedText("Theme")
                                .font(.system(size: 18))
                            Spacer()
                            Toggle("", isOn: $themeToggle)
                                .tint(Color(uiColor: user.settings.getGlobalAccent()))
                                .onChange(of: themeToggle, saveData)
                        }
                        HStack(alignment: .center) {
                            Image(systemName: "eye")
                                .font(.system(size: 24))
                                .padding(.top, 6)
                                .foregroundColor(Color.gray)
                            TranslatedText("Contrast")
                                .font(.system(size: 18))
                            Spacer()
                            Toggle("", isOn: $contrastToggle)
                                        .tint(Color(uiColor: user.settings.getGlobalAccent()))
                                .onChange(of: contrastToggle, saveData)
                        }
                    }
                    .padding(.vertical, 10)
                    VStack {
                        HStack {
                            TranslatedText("Personal Settings")
                                .font(.system(size: 20))
                            Spacer()
                        }
                        VStack {
                            HStack {
                                TranslatedText("Update Zip")
                                Spacer()
                            }
                            TextField("Zip...", text: $zipCode)
                                .padding(5)
                                .foregroundColor(Color(user.settings.getGlobalTextColorDark()))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(Color(zipError ? user.settings.getGlobalAccent() : user.settings.getGlobalTextColorDark()), lineWidth: 1)
                                )
                            HStack {
                                Button(action: {
                                    setZip(zip: zipCode)
                                }){
                                    TranslatedText("Save")
                                        .padding(.horizontal)
                                        .padding(.vertical, 5)
                                        .background(Color(uiColor: user.settings.getGlobalAccent()))
                                        .foregroundColor(.white)
                                        .cornerRadius(4)
                                }
                                Button(action: {
                                    zipCode = ""
                                }){
                                    TranslatedText("Clear")
                                        .padding(.horizontal)
                                        .padding(.vertical, 5)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 4)
                                                .stroke(Color(user.settings.getGlobalTextColorDark()), lineWidth: 1)
                                        )
                                }
                                Spacer()
                            }
                            HStack {
                                Button(action: deleteInformation) {
                                    TranslatedText("Delete Information")
                                        .padding(.horizontal)
                                        .padding(.vertical, 5)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 4)
                                                .stroke(Color(user.settings.getGlobalTextColorDark()), lineWidth: 1)
                                        )
                                }
                                Spacer()
                            }
                        }
                        .padding(.top, 6)
                    }
                    .padding(.vertical, 10)
                }
                .padding(.top, 10)
                .padding(.horizontal, 10)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .background(Color(uiColor: user.settings.getGlobalBackground()))
            .foregroundColor(Color(user.settings.getGlobalTextColor()))
        }
    }
    
    func saveData() -> Void {
        user.settings.contrast = self.contrastToggle
        user.settings.theme = self.themeToggle
        refresh = !refresh
        DataModel.saveUser(u: user)
    }
    
    func setSettings() -> Void {
        self.themeToggle = user.settings.theme
        self.contrastToggle = user.settings.contrast
        self.zipCode = user.zipcode
    }
    
    func setZip(zip: String) -> Void {
        Task {
            self.zipError = !(await user.checkValidZipCode(zip: zip))
            if (self.zipError) {
                print("Zip Error")
                return
            }
            else {
                print("Saved")
                user.zipcode = zip
                DataModel.saveUser(u: user)
            }
        }

    }
    
    func deleteInformation() -> Void {
        DataModel.deleteUser()
        onLanding = true
        
    }
}
