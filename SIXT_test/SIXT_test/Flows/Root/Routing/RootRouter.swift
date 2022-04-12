//
//  RootRouter.swift
//  SIXT_test
//
//  Created by Igor Kulik on 11.04.2022.
//

import Foundation
import SwiftUI

enum RootRoute: Int, RouteType, CaseIterable {
    case list
    case map
}

struct RootRouter: Routing {
    
    // MARK: - Properties
    
    let dataStorage: CarDataStorage

    // MARK: - Routing
    
    func view(for route: RootRoute) -> some View {
        switch route {
        case .list:
            CarListView.instance(with: dataStorage)
        case .map:
            CarMapView.instance(with: dataStorage)
        }
    }
}
