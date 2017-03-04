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
    override func tearDown() {
        FactorySwift.clean()
    }
    
    func testBuildWithBlock() {
        FactorySwift.define("Friend", of: Friend.self) {
            return [
                "name" => .generate { "Serval" }
            ]
        }
        
        let friend = FactorySwift.build("Friend", of: Friend.self)
        XCTAssertEqual(friend.name, "Serval")
    }
    
    func testBuildWithArray() {
        FactorySwift.define("Friend", of: Friend.self, with: [
            "name" => .generate { "Serval" }
        ])
        
        let friend = FactorySwift.build("Friend", of: Friend.self)
        XCTAssertEqual(friend.name, "Serval")
    }
    
    func testBuildOmittedName() {
        FactorySwift.define(of: Friend.self, with: [
            "name" => .generate { "Serval" }
        ])
        
        let friend = FactorySwift.build(of: Friend.self)
        XCTAssertEqual(friend.name, "Serval")
    }

    func testBuildWithOverride() {
        FactorySwift.define(of: Friend.self, with: [
            "name" => .generate { "Serval" }
        ])
        
        let friend = FactorySwift.build(of: Friend.self, with: [
            "name" => .generate { "Jaguar" }
        ])
        XCTAssertEqual(friend.name, "Jaguar")
    }
}
