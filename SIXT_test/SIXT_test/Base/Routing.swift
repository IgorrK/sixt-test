//
//  Routing.swift
//  SIXT_test
//
//  Created by Igor Kulik on 11.04.2022.
//

import Foundation
import SwiftUI

typealias RouteType = Hashable

protocol Routing {
    associatedtype Route: RouteType
    associatedtype View: SwiftUI.View
        
    @ViewBuilder func view(for route: Route) -> Self.View
}

protocol TabViewRouting: Routing {
    associatedtype TabRoute: RouteType
    
    @ViewBuilder func view(for tab: TabRoute) -> Self.View
}
