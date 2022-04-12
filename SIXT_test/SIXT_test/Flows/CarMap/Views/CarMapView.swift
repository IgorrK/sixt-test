//
//  CarMapView.swift
//  SIXT_test
//
//  Created by Igor Kulik on 11.04.2022.
//

import SwiftUI

struct CarMapView: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: CarMapViewModel
    
    // MARK: - View
    
    var body: some View {
        Text("Map")
    }
}

struct CarMapView_Previews: PreviewProvider {
    static var previews: some View {
        CarMapView(viewModel: CarMapViewModel(dataStorage: CarDataStorage(networkService: MockServices().network)))
    }
}

// MARK: - Factory methods
extension CarMapView {
    static func instance(with dataStorage: CarDataStorage) -> CarMapView {
        return CarMapView(viewModel: CarMapViewModel(dataStorage: dataStorage))
    }
}
