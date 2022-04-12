//
//  Car.swift
//  
//
//  Created by Igor Kulik on 11.04.2022.
//

import Foundation
import CoreLocation

public struct Car: Decodable {
    
    // MARK: - Properties
    
    public let id: String
    public let modelIdentifier: String
    public let modelName: String
    public let make: String
    public let licensePlate: String
    let latitude: Double
    let longitude: Double
    public let carImageUrl: String?
    
    public var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
