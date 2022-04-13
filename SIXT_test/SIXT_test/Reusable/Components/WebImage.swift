//
//  WebImage.swift
//  SIXT_test
//
//  Created by Igor Kulik on 13.04.2022.
//

import SwiftUI
import Kingfisher

/// A reusable view to load and show images by `url` and caches them.
/// The native `AsyncImage` view provides all required functionality except caching.
/// Since image caching wasn't explicitly mentioned in requirements
/// and proper image cache is a time-consuming task, i've decided to go with `Kingfisher` library for this.
/// Anyway, `WebImage` works as an interface to remove direct dependency from 3rd party library in code.
struct WebImage<Placeholder: View>: View {
    
    // MARK: - Properties
    
    let url: URL?
    let placeholderView: Placeholder?
    
    // MARK: - Lifecycle

    init(url: URL?,
         placeholder: (() -> Placeholder)? = nil) {
        self.url = url
        self.placeholderView = placeholder?()
    }
    
    // MARK: - View
    
    var body: some View {
        if let placeholderView = placeholderView {
            KFImage.url(url)
                .placeholder({ placeholderView })
                .resizable()
        } else {
            KFImage.url(url)
                .resizable()
        }
    }
}

// MARK: - Support optional Placeholder
extension WebImage where Placeholder == EmptyView {
    init(url: URL?) {
        self.url = url
        self.placeholderView = nil
    }
}


struct WebImage_Previews: PreviewProvider {
    static var previews: some View {
        WebImage(url: URL(string: "https://www.google.com/images/branding/googlelogo/2x/googlelogo_light_color_92x30dp.png"))
    }
}
