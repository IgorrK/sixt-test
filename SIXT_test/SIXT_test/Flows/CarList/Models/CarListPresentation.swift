//
//  CarListPresentation.swift
//  SIXT_test
//
//  Created by Igor Kulik on 12.04.2022.
//

import Foundation
import Model

struct CarListPresentation: Identifiable {
    
    // MARK: - Identifiable
    
    var id: String
    
    // MARK: - Properties
    
    let modelName: String
    let make: String
    let licensePlate: String
    let carImageUrl: URL?
    
    // MARK: - Lifecycle
    
    init(model: Car) {
        self.id = model.id
        self.modelName = model.modelName
        self.make = model.make
        self.licensePlate = model.licensePlate
        if let url = model.carImageUrl {
            self.carImageUrl = URL(string: url)
        } else {
            self.carImageUrl = nil
        }
    }
}
