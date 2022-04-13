//
//  ColorAsset.swift
//  SIXT_test
//
//  Created by Igor Kulik on 12.04.2022.
//

import Foundation
import SwiftUI

/// Normally, i'll use smth like `SwiftGen` to generate color, string assets, etc.
/// But in this particular case it'd be an overkill since here i use only a couple of assets.
/// Moreover, `SwiftGen` is not distributed via `SPM` and i don't really want to add `CocoaPods` for a single dependency.
/// And yes, this solution is not scalable at all, but seems fine for me, as for the test task.
struct ColorAsset {
    static var background: UIColor { UIColor(named: "background")! }
    static var tabBarBackground: UIColor { UIColor(named: "tabBarBackground")! }
    static var sixtOrange: UIColor { UIColor(named: "sixtOrange")! }
    static var mapAnnotationFill: UIColor { UIColor(named: "mapAnnotationFill")! }
}
