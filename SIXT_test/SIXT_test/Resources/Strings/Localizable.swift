//
//  Localizable.swift
//  SIXT_test
//
//  Created by Igor Kulik on 11.04.2022.
//

import Foundation

/// Usually i prefer some codegen tool like `SwiftGen` for localization.
/// But in this particular case, we can go with a native way since
/// the number of localizable strings is not so large.
internal struct Localizable {
    
    struct Application {
        static var ok: String { "Ok" }
    }
    
    struct Root {
        
        struct Tab {
            static var list: String { "root.tab.list".localized }
            static var map: String { "root.tab.map".localized }
        }
        
    }
    
    struct NetworkError {
        static var description: String { "networkError.description".localized }
        static var failureReason: String { "networkError.failureReason".localized }
        static var recoverySuggestion: String { "networkError.recoverySuggestion".localized }
    }
}
