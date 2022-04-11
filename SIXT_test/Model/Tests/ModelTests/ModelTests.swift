import XCTest
@testable import Model

final class ModelTests: XCTestCase {
    func testValidCar() throws {
        let modelDescriptor = DecodableResourceDescriptor<Car>(name: "CarValid",
                                                          fileType: .json,
                                                          storageType: .bundle(.module))
        let jsonDescriptor = JSONResourceDescriptor<JSONDictionary>(name: "CarValid",
                                                          fileType: .json,
                                                          storageType: .bundle(.module))
        let carModel: Car
        let carJson: JSONDictionary
        do {
            carModel = try modelDescriptor.parse()
            carJson = try jsonDescriptor.parse()
        } catch {
            throw error
        }
        XCTAssertEqual(carModel.id, carJson["id"] as? String)
        XCTAssertEqual(carModel.modelIdentifier, carJson["modelIdentifier"] as? String)
        XCTAssertEqual(carModel.modelName, carJson["modelName"] as? String)
        XCTAssertEqual(carModel.make, carJson["make"] as? String)
        XCTAssertEqual(carModel.licensePlate, carJson["licensePlate"] as? String)
        XCTAssertEqual(carModel.latitude, carJson["latitude"] as? Double)
        XCTAssertEqual(carModel.longitude, carJson["longitude"] as? Double)
        XCTAssertEqual(carModel.carImageUrl, carJson["carImageUrl"] as? String)
        XCTAssertEqual(carModel.coordinate.latitude, carModel.latitude)
        XCTAssertEqual(carModel.coordinate.longitude, carModel.longitude)
    }
    
    func testInvalidCar() throws {
        let modelDescriptor = DecodableResourceDescriptor<Car>(name: "CarInvalid",
                                                          fileType: .json,
                                                          storageType: .bundle(.module))
        XCTAssertThrowsError(try modelDescriptor.parse())
    }
}
