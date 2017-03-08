//
//  FactorySwift.swift
//  FactorySwift
//
//  Created by woxtu on 2017/03/05.
//  Copyright (c) 2017 woxtu. All rights reserved.
//

import Foundation

public struct FactorySwift<T: Factoryable> {
    private let defineBlock: () -> [Attribute]
    
    private init(defineBlock: @escaping () -> [Attribute]) {
        self.defineBlock = defineBlock
    }
    
    public static func define(type: T.Type, with defineBlock: @escaping () -> [Attribute]) -> FactorySwift<T> {
        return FactorySwift(defineBlock: defineBlock)
    }
    
    public func attributes(with overrideBlock: @escaping () -> [Attribute]) -> Attributes {
        let context = Context()
        return Attributes(rawValues: generate(context, from: merge(self.defineBlock(), with: overrideBlock())))
    }
    
    public func build(with overrideBlock: @escaping () -> [Attribute]) -> T {
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

private func generate(_ context: Context, from attributes: [Attribute]) -> [String : Any] {
    var context = context
    for attribute in attributes {
        context.set(value: attribute.generate(context), forKey: attribute.name)
    }
    return context.rawValues
}

extension FactorySwift {
    public static func define(type: T.Type, with attributes: [Attribute] = []) -> FactorySwift<T> {
        return self.define(type: type) { attributes }
    }
    
    public func attributes(with overrides: [Attribute] = []) -> Attributes {
        return self.attributes { overrides }
    }

    public func build(with overrides: [Attribute] = []) -> T {
        return self.build { overrides }
    }
}
