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
    @State private var selectedIndex = 1
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                switch selectedIndex {
                case 0:
                    HomeView()
                case 1:
                    PollingPlaceView()
                case 2:
                    Text("Profile")
                case 3:
                    ElectionsView()
                default:
                    SettingsView()
                }
            }
            
            // Navigation Bar
            NavigationBar(
                selectedIndex: $selectedIndex,
                items: [
                    NavigationItem(iconName: "house", title: "Home"),
                    NavigationItem(iconName: "magnifyingglass", title: "Search"),
                    NavigationItem(iconName: "pencil.and.list.clipboard", title: "Register"),
                    NavigationItem(iconName: "pencil.and.list.clipboard", title: "Elections"),
                    NavigationItem(iconName: "gearshape", title: "Settings")
                ]
            )
            .background(Color(uiColor: globalBackgroundAccent))
        }
        .edgesIgnoringSafeArea(.all)
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
    return MainContentView()
        .environmentObject(user)
        .environmentObject(controller)
    
}
