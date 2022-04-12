//
//  RootViewModel.swift
//  SIXT_test
//
//  Created by Igor Kulik on 12.04.2022.
//

import Foundation

final class RootViewModel {
            
    // MARK: - Properties
    
    private let dataStorage: CarDataStorage
    private let services: Services
    
    // MARK: - Lifecycle
    
    init(services: Services, dataStorage: CarDataStorage) {
        self.services = services
        self.dataStorage = dataStorage
    }
    
    // MARK: - Public methods
    
    @MainActor
    func loadData() async {
        try? await dataStorage.loadData()
    }
}

