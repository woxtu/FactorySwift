//
//  FactorySwift.swift
//  FactorySwift
//
//  Created by woxtu on 2017/03/05.
//  Copyright (c) 2017 woxtu. All rights reserved.
//

import Foundation

public struct FactorySwift {
    public static func define<T: Factoryable>(_ name: String, of type: T.Type, with attributeBlock: @escaping () -> [Attribute] = { [] }) {
    }
    
    public static func build<T: Factoryable>(_ name: String, of type: T.Type, with overrideBlock: @escaping () -> [Attribute] = { [] }) -> T {
        return T.construct(from: [:])
    }
}
