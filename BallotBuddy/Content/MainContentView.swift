//
//  MainContentView.swift
//  BallotBuddy
//
//  Created by Caden on 8/24/24.
//

import SwiftUI
import MapKit
import CoreLocation

struct MainContentView: View {
    @Binding var onLanding: Bool
    @State var selectedIndex = 0
    @EnvironmentObject var user: User
    var controller: PollUIController = PollUIController(pollingPlaces: [])
    
    var body: some View {
        if onLanding  {
            // LandingView(onLanding: $onLanding)
        } else {
            VStack(spacing: 0) {
                ZStack {
                    switch selectedIndex {
                    case 0:
                        HomeView()
                            .environmentObject(FilterButtonController())
                    case 1:
                        PollingPlaceView()
                            .environmentObject(self.controller)
                    case 2:
                        RegisterView()
                    default:
                        SettingsView(onLanding: $onLanding)
                    }
                }
                
                // Navigation Bar
                NavigationBar(
                    selectedIndex: $selectedIndex,
                    items: [
                        NavigationItem(iconName: "house", title: "Home"),
                        NavigationItem(iconName: "magnifyingglass", title: "Search"),
                        NavigationItem(iconName: "pencil.and.list.clipboard", title: "Register"),
                        NavigationItem(iconName: "gearshape", title: "Settings")
                    ]
                )
                .background(Color(uiColor: user.settings.getGlobalBackgroundAccent()))
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}


#Preview {
    @State var a = false
    // let user = User(id: 1, zipcode: "94016", targetLanguage: Locale.Language(identifier: "es-419"))
    let user = User(id: 1, zipcode: "94016", targetLanguage: Locale.Language(identifier: "en-US"))
    let place = PollingPlace(id: UUID(), location: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), name: "Place", address: "")
    let place2 = PollingPlace(id: UUID(), location: CLLocationCoordinate2D(latitude: 37.7754, longitude: -122.4200), name: "Place2", address: "")
    
    let place3 = PollingPlace(id: UUID(), location: CLLocationCoordinate2D(latitude: 37.7730, longitude: -122.4170), name: "Place3", address: "")
    
    let place4 = PollingPlace(id: UUID(), location: CLLocationCoordinate2D(latitude: 38.0000, longitude: -122.4300), name: "Place4", address: "")
    
    let place5 = PollingPlace(id: UUID(), location: CLLocationCoordinate2D(latitude: 37.900, longitude: -122.4230), name: "Place5", address: "")
    
    let place6 = PollingPlace(id: UUID(), location: CLLocationCoordinate2D(latitude: 37.7200, longitude: -122.100), name: "Place6", address: "")


    let places = [place, place2, place3, place4, place5, place6]
    let controller = PollUIController(pollingPlaces: places)
    MainContentView(onLanding: $a)
        .environmentObject(user)
        .environmentObject(controller)
    
}
