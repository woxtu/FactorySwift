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
    
    internal init(count: Int = 0) {
        self.count = count
    }
    
    internal mutating func set(value: Any, forKey key: String) {
        self.rawValues[key] = value
    }
}
