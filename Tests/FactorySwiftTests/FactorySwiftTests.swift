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
    static func construct(from attributes: [String : Any]) -> Friend {
        return Friend(name: attributes["name"] as! String)
    }
}

class FactorySwiftTests: XCTestCase {
    func testBuildWithBlock() {
        let factory = FactorySwift.define(of: Friend.self) {
            return [
                "name" => .generate { "Serval" }
            ]
        }
        
        let friend = factory.build(of: Friend.self)
        XCTAssertEqual(friend.name, "Serval")
    }
    
    func testBuildWithArray() {
        let factory = FactorySwift.define(of: Friend.self, with: [
            "name" => .generate { "Serval" }
        ])
        
        let friend = factory.build(of: Friend.self)
        XCTAssertEqual(friend.name, "Serval")
    }
    
    func testBuildWithOverride() {
        let factory = FactorySwift.define(of: Friend.self) {
            return [
                "name" => .generate { "Serval" }
            ]
        }
        
        let friend = factory.build(of: Friend.self, with: [
            "name" => .generate { "Jaguar" }
        ])
        XCTAssertEqual(friend.name, "Jaguar")
    }
}
