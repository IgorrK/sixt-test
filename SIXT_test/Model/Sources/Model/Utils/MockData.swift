//
//  MockData.swift
//  
//
//  Created by Igor Kulik on 11.04.2022.
//

import Foundation

public extension Car {
    static var mockModel: Car {
        let modelDescriptor = DecodableResourceDescriptor<Car>(name: "CarMock",
                                                               fileType: .json,
                                                               storageType: .bundle(.module))
        return try! modelDescriptor.parse()
    }
}
