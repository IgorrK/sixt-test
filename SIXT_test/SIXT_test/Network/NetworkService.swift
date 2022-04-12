//
//  NetworkService.swift
//  SIXT_test
//
//  Created by Igor Kulik on 12.04.2022.
//

import Foundation

final class NetworkService {
    
    // MARK: - Properties
        
    private let provider: NetworkServiceProvider
    
    // MARK: - Lifecycle
    
    init(provider: NetworkServiceProvider) {
        self.provider = provider
    }
    
    // MARK: - NetworkManager
        
    func performRequest<Descriptor: NetworkRequestDescriptor>(_ descriptor: Descriptor) async throws -> Descriptor.ResponseType {
        return try await provider.performRequest(descriptor)
    }
}

extension NetworkService {
    static let mock = NetworkService(provider: MockNetworkServiceProvider())
}
