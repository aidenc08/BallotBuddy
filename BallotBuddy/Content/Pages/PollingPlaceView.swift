//
//  PollingPlaceView.swift
//  BallotBuddy
//
//  Created by Aiden Chavda on 8/24/24.
//

import SwiftUI
import CoreLocation

struct PollingPlaceView: View {
    @EnvironmentObject var controller: PollUIController
    @EnvironmentObject var user: User
    var body: some View {
        GeometryReader { geometry in
            VStack {
                MapView(zipCode: user.zipcode)
                    .frame(height: geometry.size.height * 0.5) // 40% of the height for MapView
                ListView()
                    .frame(height: geometry.size.height * 0.5) // 60% of the height for ListView
            }
        }
        .edgesIgnoringSafeArea(.top) // Optional, if you want the Map to extend under the safe area
    }
}

#Preview {
    let user = User(id: 1, name: "GAA", zipcode: "94016", targetLanguage: Locale.Language(identifier: "es-419"))
    let place = PollingPlace(id: UUID(), location: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), name: "Place", address: "")
    let place2 = PollingPlace(id: UUID(), location: CLLocationCoordinate2D(latitude: 37.7754, longitude: -122.4200), name: "Place2", address: "")
    
    let place3 = PollingPlace(id: UUID(), location: CLLocationCoordinate2D(latitude: 37.7730, longitude: -122.4170), name: "Place3", address: "")
    
    let place4 = PollingPlace(id: UUID(), location: CLLocationCoordinate2D(latitude: 38.0000, longitude: -122.4300), name: "Place4", address: "")
    
    let place5 = PollingPlace(id: UUID(), location: CLLocationCoordinate2D(latitude: 37.900, longitude: -122.4230), name: "Place5", address: "")
    
    let place6 = PollingPlace(id: UUID(), location: CLLocationCoordinate2D(latitude: 37.7200, longitude: -122.100), name: "Place6", address: "")


    let places = [place, place2, place3, place4, place5, place6]
    let controller = PollUIController(pollingPlaces: places)
    return PollingPlaceView()
        .environmentObject(user)
        .environmentObject(controller)
}
