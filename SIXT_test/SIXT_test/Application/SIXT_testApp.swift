//
//  SIXT_testApp.swift
//  SIXT_test
//
//  Created by Igor Kulik on 11.04.2022.
//

import SwiftUI

@main
struct SIXT_testApp: App {

    private let services: Services = AppServices(networkServiceProvider: MockNetworkServiceProvider())
    
    var body: some Scene {
        WindowGroup {
            RootView.instance(with: services)
        }
    }
}
