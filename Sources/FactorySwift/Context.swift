//
//  Context.swift
//  FactorySwift
//
//  Created by woxtu on 2017/03/08.
//  Copyright (c) 2017 woxtu. All rights reserved.
//

import Foundation

internal struct Context {
    internal var count = 0
    internal var rawValues = [String : Any]()
    
    internal mutating func increment() {
        self.count = self.count + 1
    }
    
    internal mutating func set(value: Any, forKey key: String) {
        self.rawValues[key] = value
    }
    
    internal func value(forKey key: String) -> Any? {
        return self.rawValues[key]
    }
}
