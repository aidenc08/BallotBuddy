//
//  PollingPlace.swift
//  BallotBuddy
//
//  Created by Aiden Chavda on 8/24/24.
//

import Foundation
import MapKit
import CoreLocation

extension CLLocationCoordinate2D: @retroactive Equatable {}
extension CLLocationCoordinate2D: Codable, @retroactive Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(latitude)
        hasher.combine(longitude)
    }

    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let latitude = try container.decode(CLLocationDegrees.self, forKey: .latitude)
        let longitude = try container.decode(CLLocationDegrees.self, forKey: .longitude)
        self.init(latitude: latitude, longitude: longitude)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
    }
}

struct PollingPlace: Codable, Identifiable, Hashable {
    static func == (lhs: PollingPlace, rhs: PollingPlace) -> Bool {
        return lhs.id == rhs.id
    }
    
    public var id: UUID
    public var location: CLLocationCoordinate2D
    public var name: String
    public var address: String
    
    func equals(other: PollingPlace) -> Bool {
        return self.id == other.id
    }
}
