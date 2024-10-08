//
//  ListItemView.swift
//  BallotBuddy
//
//  Created by Aiden Chavda on 8/24/24.
//

import SwiftUI
import CoreLocation

struct ListItemView: View {
    public var place: PollingPlace
    @EnvironmentObject var controller: PollUIController
    @EnvironmentObject var user: User
    
    var body: some View {
        Button(action: select, label: {
            TranslatedText(place.name)
                .font(.headline)
                /*.background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.blue)
                        .shadow(radius: 5)
                )*/
                .foregroundColor(Color(user.settings.getGlobalTextColor()))
            Spacer()
            
        })
        .padding(20)
        .background(Color(user.settings.getGlobalBackgroundAccent()))
        if (controller.isSelected(place: place)) {
            /*TranslatedText("Selected")
                .font(.headline)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.blue)
                                    .shadow(radius: 5)
                            )
                            .foregroundColor(.white)
                            .padding()
             */
        }
    }
    
    func select() -> Void {
        controller.toggleSelected(place: self.place)
    }
}

#Preview {
    let place = PollingPlace(id: UUID(), location: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), name: "Place", address: "")
    return ListItemView(place: place).environmentObject(PollUIController(pollingPlaces: [place]))
}
