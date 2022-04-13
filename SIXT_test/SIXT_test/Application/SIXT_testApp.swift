//
//  SIXT_testApp.swift
//  SIXT_test
//
//  Created by Igor Kulik on 11.04.2022.
//

import SwiftUI

@main
struct SIXT_testApp: App {
    // MARK: - Properties
    private let services: Services = {
        let networkServiceProvider: NetworkServiceProvider
        if let provider = URLSessionNetworkServiceProvider(bundle: .main) {
            networkServiceProvider = provider
        } else {
            //Covered in tests
            networkServiceProvider = MockNetworkServiceProvider()
        }
        return AppServices(networkServiceProvider: networkServiceProvider)
    }()
    
    // MARK: - App
    
    var body: some Scene {
        WindowGroup {
            RootView.instance(with: services)
        }
    }
}
