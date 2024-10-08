//
//  LandingView.swift
//  BallotBuddy
//
//  Created by Caden on 10/6/24.
//

import SwiftUI

struct LandingView: View {
    @State var onLanding: Bool
    @State private var zipCode: String = ""
    @State private var user: User
    
    init() {
        let user = DataModel.getUser()
        if (user == nil) {
            self.onLanding = true
            self.user = User()
        }
        else {
            self.onLanding = false
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
                                    .stroke(Color(user.settings.getGlobalTextColorDark()), lineWidth: 1)
                            )
                    }
                    .padding(.horizontal, 20)
                    Spacer().frame(height: 20)
                    HStack {
                        Button(action: {
                            user.zipcode = self.zipCode
                            DataModel.saveUser(u: user)
                            onLanding = false
                        }){
                            Text("Continue")
                                .padding(.horizontal)
                                .padding(.vertical, 10)
                                .foregroundColor(Color(user.settings.getGlobalTextColor()))
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
}


#Preview {
    LandingView()
}
