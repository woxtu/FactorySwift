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
    
    public func value<T>(forName name: String) throws -> T {
        guard let rawValue = self.rawValues[name] else {
            throw Error.valueNotFound(name: name)
        }
        
        guard let value = rawValue as? T else {
            throw Error.valueIsNotType(value: rawValue, type: T.self)
        }
        
        return value
    }
}

infix operator |>

func |> <T>(attributes: Attributes, name: String) throws -> T {
    return try attributes.value(forName: name)
}
