//
//  LocationDecoder.swift
//  MarshalOne
//
//  Created by Veronika on 11.04.2023.
//

import Foundation
import CoreLocation
import MapKit

class LocationDecoder {
    func getLocation(from address: String) async throws -> Location {
        let geocoder = CLGeocoder()
        let placemarks = try await geocoder.geocodeAddressString(address)
        
        guard let placemark = placemarks.first else {
            throw NSError(domain: "getLocation", code: 1, userInfo: nil)
        }
        
        guard let latitude = placemark.location?.coordinate.latitude,
              let longitude = placemark.location?.coordinate.longitude else {
                  throw NSError(domain: "getLocation", code: 2, userInfo: nil)
              }
        
        let location = Location(latitude: latitude, longitude: longitude)
        return location
    }
}
