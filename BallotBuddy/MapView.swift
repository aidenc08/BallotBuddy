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
    @State private var annotations: [LocationAnnotation] = []

    var body: some View {
        
        Map(position: $position) {
            ForEach(annotations) { annotation in
                Annotation(coordinate: annotation.coordinate, anchor: .center, content: {
                    MapMarkerView(name: annotation.title)
                }, label: {})
            }
        }
        .onAppear {
            centerMapOnZipCode(zipCode: "10002")  // Example ZIP code
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
            
            // Create and add annotation
            let annotation = LocationAnnotation(
                id: UUID(),
                title: "ZIP Code: \(zipCode)",
                coordinate: location.coordinate
            )
            
            annotations = [annotation]
        }
    }
}

struct LocationAnnotation: Identifiable {
    let id: UUID
    let title: String
    let coordinate: CLLocationCoordinate2D
}
#Preview {
    MapView()
}
