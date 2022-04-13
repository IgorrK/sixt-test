//
//  CarAnnotationViewModel.swift
//  SIXT_test
//
//  Created by Igor Kulik on 13.04.2022.
//

import Foundation
import Model
import CoreLocation

final class CarAnnotationViewModel: ObservableObject, Identifiable {

    // MARK: - Identifiable
    
    var id: String

    // MARK: - Properties
    
    let modelName: String
    let make: String
    let licensePlate: String
    let coordinate: CLLocationCoordinate2D
    let carImageUrl: URL?
    
    @Published var state: State = .collapsed

    // MARK: - Lifecycle
    
    init(model: Car) {
        self.id = model.id
        self.modelName = model.modelName
        self.make = model.make
        self.licensePlate = model.licensePlate
        self.coordinate = model.coordinate
        if let url = model.carImageUrl {
            self.carImageUrl = URL(string: url)
        } else {
            self.carImageUrl = nil
        }
    }
}

// MARK: - Nested types
extension CarAnnotationViewModel {
    enum State: Int {
        case hidden
        case collapsed
        case expanded
    }
}
