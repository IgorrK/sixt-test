//
//  CarDataStorage.swift
//  SIXT_test
//
//  Created by Igor Kulik on 12.04.2022.
//

import Foundation
import Model

final class CarDataStorage: NSObject, ObservableObject {
    
    // MARK: - Properties
    private let networkService: RootNetworking
    
    @Published private(set) var cars = [Car]()

    // MARK: - Lifecycle
    
    init(networkService: RootNetworking) {
        
        self.networkService = networkService
        super.init()
    }
    
    // MARK: - Public methods
    
    func loadData() async throws {
        cars = try await networkService.getCarsList()
    }
}
