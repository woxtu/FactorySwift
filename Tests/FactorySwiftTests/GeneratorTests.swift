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
        XCTAssertEqual(generator.apply(context) as? String, "Serval")
    }
    
    func testValue() {
        let context = Context()
        let generator = Generator.value("Serval")
        XCTAssertEqual(generator.apply(context) as? String, "Serval")
    }
    
    func testSequence() {
        var context = Context()
        let generator = Generator.sequence { $0 }
        XCTAssertEqual(generator.apply(context) as? Int, 0)
        
        context.increment()
        XCTAssertEqual(generator.apply(context) as? Int, 1)
    }
    
    func testDepend() {
        var context = Context()
        context.rawValues["name"] = "Serval"
        let generator = Generator.depend(on: "name") { "I'm \($0 as! String)!" }
        XCTAssertEqual(generator.apply(context) as? String, "I'm Serval!")
    }
    
    func testMultipleDepend() {
        var context = Context()
        context.rawValues["greeting"] = "Hi"
        context.rawValues["name"] = "Serval"
        let generator = Generator.depend(on: ["greeting", "name"]) {
            let values = $0.flatMap { $0 as? String }
            return "\(values[0]), I'm \(values[1])!"
        }
        XCTAssertEqual(generator.apply(context) as? String, "Hi, I'm Serval!")
    }
    
    func testPick() {
        let context = Context()
        let generator = Generator.pick(from: 0 ..< 5)
        XCTAssert((0 ..< 5).contains(generator.apply(context) as! Int))
    }
}
