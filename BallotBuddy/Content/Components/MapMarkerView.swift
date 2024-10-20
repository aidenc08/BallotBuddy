//
//  MapMarkerView.swift
//  BallotBuddy
//
//  Created by Aiden Chavda on 8/24/24.
//

import SwiftUI
import CoreLocation

struct MapMarkerView: View {
    @EnvironmentObject var controller: PollUIController
    @EnvironmentObject var user: User
    public var place: PollingPlace
    var body: some View {
        VStack(spacing: 0) {
            Button(action: select, label: {
                Image(systemName: "mappin.circle.fill")
                    .font(.title)
                    .foregroundColor(.red)
            })
            TranslatedText(place.name)
                .font(.caption)
                .padding(5)
                .background(Color.white)
                .foregroundStyle(Color(user.settings.getGlobalTextColorDark()))
                .cornerRadius(8)
                .shadow(radius: 3)
        }
    }
    func select() -> Void {
        controller.select(place: self.place)
    }
}

#Preview {
    let place = PollingPlace(id: UUID(), location: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), name: "Place", address: "")
    return MapMarkerView(place: place).environmentObject(PollUIController(pollingPlaces: [place]))
}
