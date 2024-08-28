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
        Map(position: $position) {
            ForEach(controller.pollingPlaces) { annotation in
                Annotation(coordinate: annotation.location, anchor: .center, content: {
                    MapMarkerView(place: annotation)
                }, label: {})
            }
        }
        .onAppear {
            centerMapOnZipCode(zipCode: self.zipCode)  // Example ZIP code
        }
        .onChange(of: controller.selectedPlace) {
            if (controller.anySelected()) {
                centerMapOnSelected()
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
    MapView(zipCode: "10001")
}
