//
//  FactorySwift.swift
//  FactorySwift
//
//  Created by woxtu on 2017/03/05.
//  Copyright (c) 2017 woxtu. All rights reserved.
//

import Foundation

public struct FactorySwift {
    private let defineBlock: () -> [Attribute]
    
    private init(defineBlock: @escaping () -> [Attribute]) {
        self.defineBlock = defineBlock
    }
    
    public static func define<T: Factoryable>(type: T.Type, with defineBlock: @escaping () -> [Attribute]) -> FactorySwift {
        return FactorySwift(defineBlock: defineBlock)
    }
    
    public func attributes(with overrideBlock: @escaping () -> [Attribute]) -> Attributes {
        return Attributes(rawValues: generate(from: merge(self.defineBlock(), with: overrideBlock())))
    }
    
    public func build<T: Factoryable>(type: T.Type, with overrideBlock: @escaping () -> [Attribute]) -> T {
        return T.construct(from: self.attributes(with: overrideBlock))
    }
}

private func merge(_ attributes1: [Attribute], with attributes2: [Attribute]) -> [Attribute] {
    var attributes = attributes1
    for override in attributes2 {
        if let index = (attributes.index { $0.name == override.name }) {
            attributes[index] = override
        }
    }
    return attributes
}

private func generate(from attributes: [Attribute]) -> [String : Any] {
    var rawValues = [String : Any]()
    for attribute in attributes {
        rawValues[attribute.name] = attribute.generate()
    }
    return rawValues
}

extension FactorySwift {
    public static func define<T: Factoryable>(type: T.Type, with attributes: [Attribute] = []) -> FactorySwift {
        return self.define(type: type) { attributes }
    }
    
    public func attributes(with overrides: [Attribute] = []) -> Attributes {
        return self.attributes { overrides }
    }

    public func build<T: Factoryable>(type: T.Type, with overrides: [Attribute] = []) -> T {
        return self.build(type: type) { overrides }
    }
}
