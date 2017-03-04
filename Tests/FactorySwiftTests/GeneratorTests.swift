//
//  GeneratorTests.swift
//  FactorySwift
//
//  Created by woxtu on 2017/03/05.
//  Copyright (c) 2017 woxtu. All rights reserved.
//

import XCTest
@testable import FactorySwift

class GeneratorTests: XCTestCase {
    func testGenerate() {
        let generator = Generator.generate { "Serval" }
        XCTAssertEqual(generator.apply() as? String, "Serval")
    }
}
