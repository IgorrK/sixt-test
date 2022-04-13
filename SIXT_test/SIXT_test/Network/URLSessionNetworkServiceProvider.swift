//
//  URLSessionNetworkServiceProvider.swift
//  SIXT_test
//
//  Created by Igor Kulik on 13.04.2022.
//

import Foundation

final class URLSessionNetworkServiceProvider: NetworkServiceProvider {
    
    // MARK: - Properties
    
    private let urlBuilder: URLBuilder
    private var urlSession: URLSession { URLSession.shared }
    private let decoder = JSONDecoder()
    
    init?(bundle: Bundle) {
        guard let url = bundle.infoDictionary?["baseURL"] as? String else { return nil }
        self.urlBuilder = URLBuilder(baseURL: url)
    }
    
    // MARK: - NetworkServiceProvider
    
    func performRequest<Descriptor: NetworkRequestDescriptor>(_ descriptor: Descriptor) async throws -> Descriptor.ResponseType {
        
        let url = try urlBuilder.buildURL(from: descriptor)
        
        let (data, response) = try await urlSession.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }

        return try decoder.decode(Descriptor.ResponseType.self, from: data)
    }
}

// MARK: - Nested types
extension URLSessionNetworkServiceProvider {
    enum NetworkError: LocalizedError {
        case wrongURL
        case invalidResponse
        
        // MARK: - LocalizedError
        
        var errorDescription: String? {
            return Localizable.NetworkError.description
        }
        
        var failureReason: String? {
            return Localizable.NetworkError.failureReason
        }
        
        var recoverySuggestion: String? {
            return Localizable.NetworkError.recoverySuggestion
        }
    }

    fileprivate final class URLBuilder {
        
        // MARK: - Properties
        
        let baseURL: String
        
        // MARK: - Lifecycle
        
        init(baseURL: String) {
            self.baseURL = baseURL
        }
        
        // MARK: - Public methods
        
        func buildURL<Descriptor: NetworkRequestDescriptor>(from descriptor: Descriptor) throws -> URL {
            var components = URLComponents()
            components.scheme = "https"
            components.host = baseURL
            components.path = descriptor.path
            
            if let url = components.url {
                return url
            } else {
                throw NetworkError.wrongURL
            }
        }
        
    }
}
