//
//  CarMapViewModel.swift
//  SIXT_test
//
//  Created by Igor Kulik on 12.04.2022.
//

import Foundation
import Model
import Combine

final class CarMapViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var cars = [Car]()
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
            .assign(to: \.cars, on: self)
            .store(in: &anyCancellables)
    }
}
