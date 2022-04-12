//
//  Services.swift
//  SIXT_test
//
//  Created by Igor Kulik on 12.04.2022.
//

import Foundation

protocol Services {
    var network: NetworkService { get }
}

final class AppServices: Services {
    
    // MARK: - Services
    
    var network: NetworkService
    
    // MARK: - Lifecycle
    
    init(networkServiceProvider: NetworkServiceProvider) {
        self.network = NetworkService(provider: networkServiceProvider)
    }
}

final class MockServices: Services {
    var network: NetworkService = NetworkService(provider: MockNetworkServiceProvider())
}
