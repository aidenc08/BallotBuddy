//
//  MapView.swift
//  BallotBuddy
//
//  Created by Aiden Chavda on 8/23/24.
//

import SwiftUI
import MapKit
import CoreLocation



struct MapView: View {
    @State private var position = MapCameraPosition.region(MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), // Default to San Francisco
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )) 
    public var zipCode: String
    @EnvironmentObject var controller: PollUIController

    var body: some View {
        VStack {
            Map(position: $position) {
                ForEach(controller.pollingPlaces) { annotation in
                    Annotation(coordinate: annotation.location, anchor: .center, content: {
                        MapMarkerView(place: annotation)
                    }, label: {})
                }
            }
            .colorScheme(.dark)
            .onAppear {
                centerMapOnZipCode(zipCode: self.zipCode)  // Example ZIP code
            }
            .onChange(of: controller.selectedPlace) {
                if (controller.anySelected()) {
                    centerMapOnSelected()
                }
            }
        }
    }
    
    func centerMapOnZipCode(zipCode: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(zipCode) { (placemarks, error) in
            guard let placemark = placemarks?.first,
                  let location = placemark.location else {
                print("Geocoding error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            // Update the center coordinate
            position = MapCameraPosition.region(MKCoordinateRegion(
                center: location.coordinate, // Default to San Francisco
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            ))
            
        }
    }
    func centerMapOnSelected() -> Void {
        position = MapCameraPosition.region(MKCoordinateRegion(center: controller.selectedPlace!.location, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
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
