//
//  CarMapViewModel.swift
//  SIXT_test
//
//  Created by Igor Kulik on 12.04.2022.
//

import Foundation
import Model
import Combine
import MapKit
import SwiftUI

final class CarMapViewModel: ObservableObject, InteractiveViewModel {
    
    // MARK: - Properties
    
    private let dataStorage: CarDataStorage
    
    private var anyCancellables = Set<AnyCancellable>()

    @Published var coordinateRegion = MKCoordinateRegion()
    @Published var annotations = [CarAnnotationViewModel]()
    
    // MARK: - Lifecycle
    
    init(dataStorage: CarDataStorage) {
        self.dataStorage = dataStorage
        setBindings()
    }
    
    // MARK: - Private methods
    
    private func setBindings() {
        dataStorage.$cars
            .sink { cars in
                self.annotations = cars.map({ CarAnnotationViewModel(model: $0) })
                self.coordinateRegion = MKCoordinateRegion(coordinates: cars.map({ $0.coordinate }))
            }
            .store(in: &anyCancellables)
    }
    
    private func handleAnnotationSelection(_ selectedAnnotation: CarAnnotationViewModel) {
        
        let expectedState: CarAnnotationViewModel.State = {
            switch selectedAnnotation.state {
            case .collapsed:
                return .expanded
            case .expanded:
                return .collapsed
            default:
                return .collapsed
            }
        }()
        
        if expectedState == .expanded {
            coordinateRegion = MKCoordinateRegion(center: selectedAnnotation.coordinate,
                                                  span: coordinateRegion.span)
        }
        
        for annotation in annotations {
            if annotation.id == selectedAnnotation.id {
                annotation.state = expectedState
            } else {
                switch expectedState {
                case .collapsed: // i.e. will be collapsed, show other annotations
                    annotation.state = .collapsed
                case .expanded: // i.e. will be expanded, hide other annotations
                    annotation.state = .hidden
                default:
                    annotation.state = .collapsed
                }
            }
        }
    }
    
    private func resetAnnotations() {
        annotations.forEach({ $0.state = .collapsed })
    }
    
    // MARK: - InteractiveViewModel
    
    func handleInput(event: Event) {
        switch event {
        case .onAppear:
            resetAnnotations()
        case .annotationSelection(let carAnnotationViewModel):
            handleAnnotationSelection(carAnnotationViewModel)
        }
    }
}

extension CarMapViewModel {
    enum Event: Hashable {
        
        case onAppear
        case annotationSelection(CarAnnotationViewModel)
        
        // MARK: - Hashable
        
        static func == (lhs: CarMapViewModel.Event, rhs: CarMapViewModel.Event) -> Bool {
            switch (lhs, rhs) {
            case (.annotationSelection(let lvm), .annotationSelection(let rvm)):
                return lvm.id == rvm.id
            default:
                return lhs == rhs
            }
        }
        
        func hash(into hasher: inout Hasher) {
            switch self {
            case .annotationSelection(let vm):
                hasher.combine(vm.id)
            default:
                break
            }
        }
    }
}
