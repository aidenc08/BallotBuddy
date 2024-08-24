//
//  PollingPlaceView.swift
//  BallotBuddy
//
//  Created by Aiden Chavda on 8/24/24.
//

import SwiftUI

struct PollingPlaceView: View {
    @EnvironmentObject var controller: PollUIController
    @EnvironmentObject var user: User
    var body: some View {
        MapView(zipCode: user.zipcode)
        ListView()
    }
}

#Preview {
    PollingPlaceView()
}
