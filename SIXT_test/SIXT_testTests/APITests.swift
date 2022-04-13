//
//  APITests.swift
//  SIXT_testTests
//
//  Created by Igor Kulik on 13.04.2022.
//

import XCTest
@testable import SIXT_test
@testable import Model

class APITests: XCTestCase {


    func testBaseURL() throws {
        let bundle = Bundle.main
        let baseURL = bundle.infoDictionary?["baseURL"] as? String
        
        XCTAssertEqual(baseURL, "cdn.sixt.io")
    }
    
    func testURLBuilderSuccess() async throws {
        let provider: URLSessionNetworkServiceProvider
        if let serviceProvider = URLSessionNetworkServiceProvider(bundle: Bundle.main) {
            provider = serviceProvider
        } else {
            assertionFailure("Could not init URLSessionNetworkServiceProvider")
            return
        }
        let service = NetworkService(provider: provider)
        let descriptor = CarListRequestDescriptor()
        
        do {
            _ = try await service.performRequest(descriptor)
        } catch {
            throw error
        }
    }
    
    func testURLBuilderFailure() async throws {
        let provider: URLSessionNetworkServiceProvider
        if let serviceProvider = URLSessionNetworkServiceProvider(bundle: Bundle.main) {
            provider = serviceProvider
        } else {
            assertionFailure("Could not init URLSessionNetworkServiceProvider")
            return
        }
        let service = NetworkService(provider: provider)
        let descriptor = BadPathRequestDescriptor()
        
        do {
            _ = try await service.performRequest(descriptor)
            assertionFailure("Bad path shouldn't return a response")
            return

        } catch {
            XCTAssertEqual(error as? URLSessionNetworkServiceProvider.NetworkError, URLSessionNetworkServiceProvider.NetworkError.wrongURL)
        }
    }

    func testInvalidResponseError() async throws {
        let provider: URLSessionNetworkServiceProvider
        if let serviceProvider = URLSessionNetworkServiceProvider(bundle: Bundle.main) {
            provider = serviceProvider
        } else {
            assertionFailure("Could not init URLSessionNetworkServiceProvider")
            return
        }
        let service = NetworkService(provider: provider)
        let descriptor = InvalidResponseRequestDescriptor()
        
        do {
            _ = try await service.performRequest(descriptor)
            assertionFailure("Invalid path shouldn't return a response")
            return

        } catch {
            XCTAssertEqual(error as? URLSessionNetworkServiceProvider.NetworkError, URLSessionNetworkServiceProvider.NetworkError.invalidResponse)
        }
    }
    
    func testDecodingError() async throws {
        let provider: URLSessionNetworkServiceProvider
        if let serviceProvider = URLSessionNetworkServiceProvider(bundle: Bundle.main) {
            provider = serviceProvider
        } else {
            assertionFailure("Could not init URLSessionNetworkServiceProvider")
            return
        }
        let service = NetworkService(provider: provider)
        let descriptor = DecodingErrorRequestDescriptor()
        
        do {
            _ = try await service.performRequest(descriptor)
            assertionFailure("Invalid path shouldn't return a response")
            return

        } catch {
            XCTAssertEqual(error as? URLSessionNetworkServiceProvider.NetworkError, URLSessionNetworkServiceProvider.NetworkError.decodingError)
        }
    }
}

fileprivate struct BadPathRequestDescriptor: NetworkRequestDescriptor {
        typealias ResponseType = [Car]
        
        var path: String { "codingtask/cars" }
        
        var mockResponse: [Car] { Car.mockModelList }
}

fileprivate struct InvalidResponseRequestDescriptor: NetworkRequestDescriptor {
        typealias ResponseType = [Car]
        
        var path: String { "/codingtask/planes" }
        
        var mockResponse: [Car] { Car.mockModelList }
}

fileprivate struct DecodingErrorRequestDescriptor: NetworkRequestDescriptor {
    
    struct BadResponse: Codable {
        let foo: String
    }
    
    typealias ResponseType = [BadResponse]
    
    var path: String { "/codingtask/cars" }
    
    var mockResponse: [BadResponse] { [BadResponse(foo: "bar")] }
}
