//
//  RootView.swift
//  SIXT_test
//
//  Created by Igor Kulik on 11.04.2022.
//

import SwiftUI
import Model

struct RootView: RoutableView {
    
    // MARK: - Properties
    
    var viewModel: RootViewModel
    var router: RootRouter

    // MARK: - View
    
    var body: some View {
        
        TabView {
            ForEach(RootRoute.allCases, id: \.self) { route in
                router
                    .view(for: route)
                    .tabItemStyle(route: route)
            }
        }
        .task {
            /// Decided to load data into shared storage here, since  the data is common
            /// between two tabs and injected inside `RootRouter`
            await viewModel.loadData()
        }
        .accentColor(Color(ColorAsset.sixtOrange))
        .onAppear {
            UITabBar.appearance().backgroundColor = ColorAsset.tabBarBackground
            UITabBar.appearance().unselectedItemTintColor = .secondaryLabel
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        let services = MockServices()
        let dataStorage = CarDataStorage(networkService: services.network)
        RootView(viewModel: RootViewModel(services: services, dataStorage: dataStorage),
                 router: RootRouter(dataStorage: dataStorage))
    }
}

// MARK: - Factory methods
extension RootView {
    static func instance(with services: Services) -> RootView {
        let dataStorage = CarDataStorage(networkService: services.network)
        return RootView(viewModel: RootViewModel(services: services, dataStorage: dataStorage),
                 router: RootRouter(dataStorage: dataStorage))
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
