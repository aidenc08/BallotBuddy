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
    @EnvironmentObject var user: User

    var body: some View {
        VStack {
            HStack {
                Text("Settings")
                    .font(.system(size: 30))
                    .frame(maxWidth: .infinity)
                
            }
            .onAppear(perform: {
                setSettings()
                saveData()
            })
            .padding(.top, 70)
            .padding(.bottom, 20)
            .background(Color(uiColor: globalBackgroundAccent))
            .ignoresSafeArea()
            VStack {
                HStack {
                    Text("App Settings")
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
                        Text("Theme")
                            .font(.system(size: 18))
                        Spacer()
                        Toggle("", isOn: $themeToggle)
                            .tint(Color(uiColor: globalAccent))
                            .onChange(of: themeToggle, saveData)
                    }
                    HStack(alignment: .center) {
                        Image(systemName: "eye")
                            .font(.system(size: 24))
                            .padding(.top, 6)
                            .foregroundColor(Color.gray)
                        Text("Contrast")
                            .font(.system(size: 18))
                        Spacer()
                        Toggle("", isOn: $contrastToggle)
                            .tint(Color(uiColor: globalAccent))
                            .onChange(of: contrastToggle, saveData)
                    }
                }
                .padding(.vertical, 10)
                VStack {
                    HStack {
                        Text("Personal Settings")
                            .font(.system(size: 20))
                        Spacer()
                    }
                    VStack {
                        HStack {
                            Text("Update Zip")
                            Spacer()
                        }
                        TextField("Zip...", text: $zipCode)
                            .padding(5)
                            .foregroundColor(Color(globalTextColorDark))
                            .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(Color(globalTextColorDark), lineWidth: 1)
                            )
                        HStack {
                            Button(action: {
                                setZip(zip: zipCode)
                            }){
                                Text("Save")
                                    .padding(.horizontal)
                                    .padding(.vertical, 5)
                                    .background(Color(uiColor: globalAccent))
                                    .foregroundColor(.white)
                                    .cornerRadius(4)
                            }
                            Button(action: {
                                
                            }){
                                Text("Reset")
                                    .padding(.horizontal)
                                    .padding(.vertical, 5)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 4)
                                            .stroke(Color(globalTextColorDark), lineWidth: 1)
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
        .background(Color(uiColor: globalBackground))
        .foregroundColor(Color(globalTextColor))
    }
    
    func saveData() -> Void {
        user.settings.contrast = self.contrastToggle
        user.settings.theme = self.themeToggle
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
                user.zipcode = zip
                DataModel.saveUser(u: user)
            }
        }

    }
}

#Preview {
    SettingsView()
}
