//
//  NetworkRequestDescriptor.swift
//  SIXT_test
//
//  Created by Igor Kulik on 12.04.2022.
//

import Foundation
import Model

protocol NetworkRequestDescriptor {
    associatedtype ResponseType: Decodable
    
    var path: String { get }

    var mockResponse: ResponseType { get }
}
