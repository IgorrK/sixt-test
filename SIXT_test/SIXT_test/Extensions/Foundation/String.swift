//
//  String.swift
//  SIXT_test
//
//  Created by Igor Kulik on 11.04.2022.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
