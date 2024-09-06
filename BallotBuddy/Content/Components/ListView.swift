//
//  ListView.swift
//  BallotBuddy
//
//  Created by Aiden Chavda on 8/24/24.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var controller: PollUIController
    var body: some View {
        ScrollViewReader { proxy in
            List {
                ForEach(controller.pollingPlaces) { place in
                    ListItemView(place: place).id(place.id)
                        .listRowBackground(Color(uiColor: globalBackgroundAccent))
                        .foregroundColor(Color(globalTextColor))
                }
            }.onChange(of: controller.selectedPlace) {
                print("changed")
                if (controller.anySelected()) {                    
                    proxy.scrollTo(controller.selectedPlace?.id)
                }
            }
        }

    }
}

#Preview {
    ListView()
}
