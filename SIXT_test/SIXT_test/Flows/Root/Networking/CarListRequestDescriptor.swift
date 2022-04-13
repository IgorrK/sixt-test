//
//  CarListRequestDescriptor.swift
//  SIXT_test
//
//  Created by Igor Kulik on 12.04.2022.
//

import Foundation
import Model

struct CarListRequestDescriptor: NetworkRequestDescriptor {
    typealias ResponseType = [Car]
    
    var path: String { "/codingtask/cars" }
    
    var mockResponse: [Car] { Car.mockModelList }
}
