//
//  FactorySwift.swift
//  FactorySwiftTests
//
//  Created by woxtu on 2017/03/05.
//  Copyright (c) 2017 woxtu. All rights reserved.
//

import XCTest
@testable import FactorySwift

class FactorySwiftTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(FactorySwift().text, "Hello, World!")
    }


    static var allTests : [(String, (FactorySwiftTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
