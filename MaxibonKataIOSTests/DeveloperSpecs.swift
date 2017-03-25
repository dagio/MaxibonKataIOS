import Foundation
import XCTest
import SwiftCheck
@testable import MaxibonKataIOS

class DeveloperSpecs: XCTestCase {
    func testAll() {
        property("Developers always take a positive number of maxibons") <- forAll { (developer: Developer) in
            developer.numberOfMaxibonsToGet >= 0
        }
    }
}
