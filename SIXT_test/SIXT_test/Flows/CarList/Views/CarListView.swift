//
//  CarListView.swift
//  SIXT_test
//
//  Created by Igor Kulik on 11.04.2022.
//

import SwiftUI

struct CarListView: View {
    
    // MARK: - Properties
    
    @StateObject var viewModel: CarListViewModel
    
    // MARK: - View
    
    var body: some View {
        List {
            ForEach(viewModel.cars) { presentation in
                CarListItem(presentation: presentation)
            }
            .listRowSeparator(.hidden)
        }
        .alert(error: $viewModel.error)
        .listStyle(.plain)
        .background(Color(ColorAsset.background))
        .refreshable {
            await viewModel.handleInput(event: .onRefresh)
        }
    }
}

struct CarListView_Previews: PreviewProvider {
    static var previews: some View {
        CarListView(viewModel: CarListViewModel(dataStorage: CarDataStorage(networkService: MockServices().network)))
    }
}

// MARK: - Factory methods
extension CarListView {
    static func instance(with dataStorage: CarDataStorage) -> CarListView {
        return CarListView(viewModel: CarListViewModel(dataStorage: dataStorage))
    }
}
