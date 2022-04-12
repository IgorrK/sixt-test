//
//  CarListViewModel.swift
//  SIXT_test
//
//  Created by Igor Kulik on 12.04.2022.
//

import Foundation
import Model
import Combine

final class CarListViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var cars = [CarListPresentation]()
    private let dataStorage: CarDataStorage
    
    private var anyCancellables = Set<AnyCancellable>()

    // MARK: - Lifecycle
    
    init(dataStorage: CarDataStorage) {
        self.dataStorage = dataStorage
        setBindings()
    }
    
    // MARK: - Private methods
    
    private func setBindings() {
        dataStorage.$cars
            .sink { self.cars = $0.map({ CarListPresentation(model: $0) }) }
            .store(in: &anyCancellables)
    }
}
