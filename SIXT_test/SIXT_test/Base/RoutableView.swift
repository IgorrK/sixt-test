//
//  RoutableView.swift
//  SIXT_test
//
//  Created by Igor Kulik on 11.04.2022.
//

import Foundation
import SwiftUI

protocol RoutableView: View {
    associatedtype Router: Routing
    
    var router: Router { get }
}
