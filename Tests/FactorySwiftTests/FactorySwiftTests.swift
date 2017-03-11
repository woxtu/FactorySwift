//
//  FactorySwiftTests.swift
//  FactorySwift
//
//  Created by woxtu on 2017/03/05.
//  Copyright (c) 2017 woxtu. All rights reserved.
//

import XCTest
@testable import FactorySwift

struct Friend {
    let name: String
}

extension Friend : Factoryable {
    static func construct(from attributes: Attributes) throws -> Friend {
        return try Friend(name: attributes |> "name")
    }
}

class FactorySwiftTests: XCTestCase {
    func testBuildObject() {
        let factory = FactorySwift.define(type: Friend.self, with: [
            "name": .generate { "Serval" },
        ])
        
        let friend = try! factory.build()
        XCTAssertEqual(friend.name, "Serval")
    }
    
    func testBuildObjectWithOverriding() {
        let factory = FactorySwift.define(type: Friend.self, with: [
            "name": .generate { "Serval" },
        ])
        
        let friend = try! factory.build(with: [
            "name": .generate { "Jaguar" },
        ])
        XCTAssertEqual(friend.name, "Jaguar")
    }
    
    func testBuildMultipleObjects() {
        let factory = FactorySwift.define(type: Friend.self, with: [
            "name": .sequence { "friend\($0)" },
        ])

        let count = 3
        let friends = try! factory.build(count: count)
        XCTAssertEqual(friends.count, count)
        for n in 0 ..< count {
            XCTAssertEqual(friends[n].name, "friend\(n)")
        }
    }
    
    func testThrowsValueNotFoundError() {
        let factory = FactorySwift.define(type: Friend.self)
        XCTAssertThrowsError(try factory.build())
    }
    
    func testThrowsValueIsNotTypeError() {
        let factory = FactorySwift.define(type: Friend.self, with: [
            "name": .generate { 42 },
        ])
        XCTAssertThrowsError(try factory.build())
    }
}
