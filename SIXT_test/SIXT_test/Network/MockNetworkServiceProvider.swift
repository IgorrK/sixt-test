//
//  MockNetworkServiceProvider.swift
//  SIXT_test
//
//  Created by Igor Kulik on 12.04.2022.
//

import Foundation

final class MockNetworkServiceProvider: NetworkServiceProvider {
        
    // MARK: - NetworkServiceProvider
    
    func performRequest<Descriptor: NetworkRequestDescriptor>(_ descriptor: Descriptor) async throws -> Descriptor.ResponseType {
        return descriptor.mockResponse
    }
}
