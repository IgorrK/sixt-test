//
//  MKCoordinateRegion.swift
//  SIXT_test
//
//  Created by Igor Kulik on 13.04.2022.
//

import Foundation
import MapKit

extension MKCoordinateRegion {
        
    /// Creates a coordinate region embedding an array of coordinates.
    ///
    /// I've tried to achieve this with native means by using `MKMapRegion.union` but it didn't provide a proper result.
    ///
    /// - Parameters:
    ///   - coordinates: Coordinates to be displayed in region.
    init(coordinates: [CLLocationCoordinate2D]) {
        
        var minLatitude: CLLocationDegrees = 90.0
        var maxLatitude: CLLocationDegrees = -90.0
        var minLongitude: CLLocationDegrees = 180.0
        var maxLongitude: CLLocationDegrees = -180.0
        
        for coordinate in coordinates {
            let latitude = Double(coordinate.latitude)
            let longitude = Double(coordinate.longitude)
            
            minLatitude = min(minLatitude, latitude)
            minLongitude = min(minLongitude, longitude)
            maxLatitude = max(maxLatitude, latitude)
            maxLongitude = max(maxLongitude, longitude)
        }
        
        let spanMultiplier: Double = 2.0 // used to give some extra padding
        
        let span = MKCoordinateSpan(latitudeDelta: (maxLatitude - minLatitude) * spanMultiplier,
                                    longitudeDelta: (maxLongitude - minLongitude) * spanMultiplier)
        let center = CLLocationCoordinate2DMake(maxLatitude - span.latitudeDelta / spanMultiplier / 2.0,
                                                maxLongitude - span.longitudeDelta / spanMultiplier / 2.0)
        self.init(center: center, span: span)
    }
}
