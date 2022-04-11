//
//  RootView.swift
//  SIXT_test
//
//  Created by Igor Kulik on 11.04.2022.
//

import SwiftUI

struct RootView: RoutableView {
    var router: RootRouter

    var body: some View {
        
        TabView {
            ForEach(RootRoute.allCases, id: \.self) { route in
                router
                    .view(for: route)
                    .tabItemStyle(route: route)
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(router: RootRouter())
    }
}

// MARK: - Factory methods
extension RootView {
    static func instance() -> RootView {
        return RootView(router: RootRouter())
    }
}

// MARK: - TabItems

fileprivate extension View {
    func tabItemStyle(route: RootRoute) -> some View {
        let systemImageName: String
        var title: String
        
        switch route {
        case .list:
            systemImageName = SFSymbols.List.bullet
            title = Localizable.Root.Tab.list
        case .map:
            systemImageName = SFSymbols.Map.default
            title = Localizable.Root.Tab.map
        }
        return self
            .tabItem {
                Image(systemName: systemImageName)
                Text(title)
            }
            .tag(route.rawValue)
    }
}
