//
//  Attributes.swift
//  FactorySwift
//
//  Created by woxtu on 2017/03/07.
//  Copyright (c) 2017 woxtu. All rights reserved.
//

import Foundation

public struct Attributes {
    private let rawValues: [String : Any]
    
    internal init(rawValues: [String : Any]) {
        self.rawValues = rawValues
    }
    
    public func value<T>(for key: String) -> T {
        guard let rawValue = self.rawValues[key] else {
            fatalError("Cannot find value for key: \(key)")
        }
        
        guard let value = rawValue as? T else {
            fatalError("Cannot cast value to type: \(String(describing: T.self))")
        }
        
        return value
    }
}
