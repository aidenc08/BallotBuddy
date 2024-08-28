//
//  ListItemView.swift
//  BallotBuddy
//
//  Created by Aiden Chavda on 8/24/24.
//

import SwiftUI
import CoreLocation

struct ListItemView: View {
    @EnvironmentObject var controller: PollUIController
    public var place: PollingPlace
    var body: some View {
        Button(action: select, label: {
            TranslatedText(place.name)
                .font(.headline)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.blue)
                        .shadow(radius: 5)
                )
                .foregroundColor(.white)
                .padding()
        })
        if (controller.isSelected(place: place)) {
            TranslatedText("Selected")
                .font(.headline)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.blue)
                                    .shadow(radius: 5)
                            )
                            .foregroundColor(.white)
                            .padding()
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
