//
//  Error.swift
//  FactorySwift
//
//  Created by woxtu on 2017/03/10.
//  Copyright (c) 2017 woxtu. All rights reserved.
//

import Foundation

public enum Error : Swift.Error {
    case valueNotFound(name: String)
    case valueIsNotType(value: Any, type: Any.Type)
}

extension Error : CustomStringConvertible {
    public var description: String {
        switch self {
        case let .valueNotFound(name: name):
            return "Cannot find value for name '\(name)'"
            
        case let .valueIsNotType(value: value, type: type):
            return "Cannot cast value '\(value)' of \(Swift.type(of: value)) to \(type)"
        }
    }
}
