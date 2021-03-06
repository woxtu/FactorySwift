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
        let context = Context()
        let generator = Generator.generate { "Serval" }
        XCTAssertEqual(try! generator.run(on: context) as? String, "Serval")
    }
    
    func testValue() {
        let context = Context()
        let generator = Generator.value("Serval")
        XCTAssertEqual(try! generator.run(on: context) as? String, "Serval")
    }
    
    func testSequence() {
        var context = Context()
        let generator = Generator.sequence { $0 }
        XCTAssertEqual(try! generator.run(on: context) as? Int, 0)
        
        context.count = context.count + 1
        XCTAssertEqual(try! generator.run(on: context) as? Int, 1)
    }
        
    func testPick() {
        let context = Context()
        let generator = Generator.pick(from: 0 ..< 5)
        XCTAssert((0 ..< 5).contains(try! generator.run(on: context) as! Int))
    }
    
    func testBuild() {
        let factory = FactorySwift.define(type: Friend.self, with: [
            "name": .value("Serval"),
        ])
        
        let context = Context()
        let generator = Generator.build(using: factory)
        XCTAssertNotNil(try! generator.run(on: context) as? Friend)
    }
}
