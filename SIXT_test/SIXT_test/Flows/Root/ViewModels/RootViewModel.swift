//
//  RootViewModel.swift
//  SIXT_test
//
//  Created by Igor Kulik on 12.04.2022.
//

import Foundation

final class RootViewModel: ObservableObject {
            
    // MARK: - Properties
    
    private let dataStorage: CarDataStorage
    private let services: Services
    
    @Published var error: Error?

    // MARK: - Lifecycle
    
    init(services: Services, dataStorage: CarDataStorage) {
        self.services = services
        self.dataStorage = dataStorage
    }
    
    // MARK: - Public methods
    
    @MainActor
    func loadData() async {
        do {
            try await dataStorage.loadData()
        } catch {
            self.error = error
        }
    }
}

