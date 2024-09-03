//
//  SettingsView.swift
//  BallotBuddy
//
//  Created by Caden on 8/30/24.
//
import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Settings")
                    .font(.system(size: 30))
                    .frame(maxWidth: .infinity)
                
            }
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
                    }
                    HStack(alignment: .center) {
                        Image(systemName: "eye")
                            .font(.system(size: 24))
                            .padding(.top, 6)
                            .foregroundColor(Color.gray)
                        Text("Contrast")
                            .font(.system(size: 18))
                        Spacer()
                    }
                }
                .padding(.vertical, 10)
                HStack {
                    Text("Personal Settings")
                        .font(.system(size: 20))
                    Spacer()
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
}

#Preview {
    SettingsView()
}
