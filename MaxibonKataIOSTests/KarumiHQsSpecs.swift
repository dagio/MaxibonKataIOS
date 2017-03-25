import Foundation
import XCTest
import SwiftCheck
@testable import MaxibonKataIOS

class KarumiHQsSpecs: XCTestCase {
    func testAll() {
        property("There are always at least 2 maxibons left after ONE developer open the fridge") <- forAll { (developer: Developer) in
            let headQuarter = KarumiHQs()
            headQuarter.openFridge(developer)

            print("There are \(headQuarter.maxibonsLeft) maxibons left after \(developer.name) opened the fridge")

            return headQuarter.maxibonsLeft > 2
        }

        property("There are always at least 2 maxibons left after ONE developer open the fridge and to it untill we have 10 success",
                 arguments: CheckerArguments(maxAllowableSuccessfulTests: 10)) <- forAll { (developer: Developer) in
            let headQuarter = KarumiHQs()
            headQuarter.openFridge(developer)

            print("There are \(headQuarter.maxibonsLeft) maxibons left after \(developer.name) opened the fridge")

            return headQuarter.maxibonsLeft > 2
        }

        property("There are always at least 2 maxibons left after MANY developers open the fridge") <- forAll { (developers: [Developer]) in
            let headQuarter = KarumiHQs()
            headQuarter.openFridge(developers)

            print("There are \(headQuarter.maxibonsLeft) maxibons left after \(developers.count) developers opened the fridge")

            return headQuarter.maxibonsLeft > 2
        }

        property("A message is sent when hungry developers open the fridge") <- forAll(Developer.arbitraryHungry) { (developer: Developer) in
            let chat = MockChat()
            let headQuarter = KarumiHQs(chat: chat)
            headQuarter.openFridge(developer)

            return chat.messageSent != nil
         }

        property("No message is sent when not very hungry developers open the fridge") <- forAll(Developer.arbitraryNotSoHungry) { (developer: Developer) in
            let chat = MockChat()
            let headQuarter = KarumiHQs(chat: chat)
            headQuarter.openFridge(developer)

            return chat.messageSent == nil
        }
    }
}
