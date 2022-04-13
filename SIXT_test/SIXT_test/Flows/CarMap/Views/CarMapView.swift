//
//  CarMapView.swift
//  SIXT_test
//
//  Created by Igor Kulik on 11.04.2022.
//

import SwiftUI
import MapKit

struct CarMapView: View {
    
    // MARK: - Properties
    
    @StateObject var viewModel: CarMapViewModel
    
    // MARK: - View
    
    var body: some View {
        Map(coordinateRegion: $viewModel.coordinateRegion,
            annotationItems: viewModel.annotations) { annotationVM in
            MapAnnotation(coordinate: annotationVM.coordinate,
                          anchorPoint: CGPoint(x: 0.5, y: 1.0),
                          content: {
                CarAnnotation(viewModel: annotationVM)
                
                    .onTapGesture {
                        withAnimation {
                            viewModel.handleInput(event: .annotationSelection(annotationVM))
                        }
                    }
            })
        }
            .ignoresSafeArea()
            .onAppear {
                viewModel.handleInput(event: .onAppear)
            }
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
