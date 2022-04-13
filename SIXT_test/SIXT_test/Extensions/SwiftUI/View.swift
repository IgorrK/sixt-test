//
//  View.swift
//  SIXT_test
//
//  Created by Igor Kulik on 13.04.2022.
//

import SwiftUI

extension View {
    func alert(error: Binding<Error?>) -> some View {
    
        let title: Text = {
            let string = (error.wrappedValue as? LocalizedError)?.localizedDescription
            ?? (error.wrappedValue as NSError?)?.localizedDescription
            ?? ""
            
            return Text(string)
        }()
        
        let message: Text? = {
            let failureReason = (error.wrappedValue as? LocalizedError)?.failureReason
            ?? (error.wrappedValue as NSError?)?.localizedFailureReason
            
            let recoverySuggestion = (error.wrappedValue as? LocalizedError)?.recoverySuggestion
            ?? (error.wrappedValue as NSError?)?.localizedRecoverySuggestion
            
            let message = [failureReason, recoverySuggestion].compactMap({ $0 }).joined(separator: "\n")
            return message.isEmpty ? nil : Text(message)
        }()
        
        return self
            .alert(isPresented: .constant(error.wrappedValue != nil), content: {
                Alert(title: title,
                      message: message,
                      dismissButton:  .default(Text(Localizable.Application.ok), action: { error.wrappedValue = nil })
                      )
            })
    }
}
