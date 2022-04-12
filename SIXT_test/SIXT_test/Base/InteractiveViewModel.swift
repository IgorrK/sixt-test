//
//  InteractiveViewModel.swift
//  SIXT_test
//
//  Created by Igor Kulik on 12.04.2022.
//

import Foundation

typealias EventType = Hashable

protocol InteractiveViewModel {
    associatedtype Event: EventType

    func handleInput(event: Event)
}
