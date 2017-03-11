//
//  FactorySwift.swift
//  FactorySwift
//
//  Created by woxtu on 2017/03/05.
//  Copyright (c) 2017 woxtu. All rights reserved.
//

import Foundation

public class FactorySwift<T: Factoryable> {
    private let defineBlock: () -> [String : Generator]
    
    private init(defineBlock: @escaping () -> [String : Generator]) {
        self.defineBlock = defineBlock
    }
    
    public static func define(type: T.Type, with defineBlock: @escaping () -> [String : Generator]) -> FactorySwift<T> {
        return FactorySwift(defineBlock: defineBlock)
    }
    
    public func build(with overrideBlock: @escaping () -> [String : Generator]) throws -> T {
        let context = Context()
        let rawValues = try generate(context, from: merge(self.defineBlock(), with: overrideBlock()))
        return try T.construct(from: Attributes(rawValues: rawValues))
    }
    
    public func build(count: Int, with overrideBlock: @escaping () -> [String : Generator]) throws -> [T] {
        return try (0 ..< count).map {
            let context = Context(count: $0)
            let rawValues = try generate(context, from: merge(self.defineBlock(), with: overrideBlock()))
            return try T.construct(from: Attributes(rawValues: rawValues))
        }
    }
}

private func merge(_ generators1: [String : Generator], with generators2: [String : Generator]) -> [String : Generator] {
    var generators = generators1
    for (name, generator) in generators2 {
        generators[name] = generator
    }
    return generators
}

private func generate(_ context: Context, from generators: [String : Generator]) throws -> [String : Any] {
    var context = context
    for (name, generator) in generators {
        context.set(value: try generator.run(on: context), forKey: name)
    }
    return context.rawValues
}

extension FactorySwift {
    public static func define(type: T.Type, with generators: [String : Generator] = [:]) -> FactorySwift<T> {
        return self.define(type: type) { generators }
    }
    
    public func build(with overrides: [String : Generator] = [:]) throws -> T {
        return try self.build { overrides }
    }
    
    public func build(count: Int, with overrides: [String : Generator] = [:]) throws -> [T] {
        return try self.build(count: count) { overrides }
    }
}
