//
//  RootNetworking.swift
//  SIXT_test
//
//  Created by Igor Kulik on 12.04.2022.
//

import Foundation
import Model

protocol RootNetworking {
    func getCarsList() async throws -> [Car]
}

extension NetworkService: RootNetworking {
    func getCarsList() async throws -> [Car] {
        try await performRequest(CarListRequestDescriptor())
    }
}
