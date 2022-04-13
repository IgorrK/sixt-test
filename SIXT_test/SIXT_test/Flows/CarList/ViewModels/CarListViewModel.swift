//
//  CarListViewModel.swift
//  SIXT_test
//
//  Created by Igor Kulik on 12.04.2022.
//

import Foundation
import Model
import Combine

final class CarListViewModel: ObservableObject, InteractiveViewModel {
    
    // MARK: - Properties
    
    @Published var cars = [CarListPresentation]()
    @Published var error: Error?

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
    
    @MainActor
    private func refreshData() async {
        do {
            try await dataStorage.loadData()
        } catch {
            self.error = error
        }
    }
    
    // MARK: - InteractiveViewModel
    
    func handleInput(event: Event) async {
        switch event {
        case .onRefresh:
            await refreshData()
//            try? await dataStorage.loadData()
        }
    }
}

// MARK: - Nested types
extension CarListViewModel {
    enum Event {
        case onRefresh
    }
}
