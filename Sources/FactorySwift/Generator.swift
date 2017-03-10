//
//  Generator.swift
//  FactorySwift
//
//  Created by woxtu on 2017/03/05.
//  Copyright (c) 2017 woxtu. All rights reserved.
//

import Foundation

public struct Generator {
    internal var apply: (Context) throws -> Any
    
    private init(apply: @escaping (Context) throws -> Any) {
        self.apply = apply
    }
    
    /// Create a Generator that returns generated value
    public static func generate(_ f: @escaping () throws -> Any) -> Generator {
        return Generator { _ in try f() }
    }
    
    /// Create a Generator that returns fixed value
    public static func value(_ value: Any) -> Generator {
        return Generator { _ in value }
    }
    
    /// Create a Generator that returns sequential value
    public static func sequence(_ f: @escaping (Int) throws -> Any) -> Generator {
        return Generator { try f($0.count) }
    }
        
    /// Create a Generator that returns value random picked from a passed sequence
    public static func pick<S: Sequence>(from sequence: S) -> Generator {
        let array = Array(sequence)
        return Generator { _ in array[Int(arc4random_uniform(UInt32(array.count)))] }
    }
    
    /// Create a Generator that returns value built using a passed factory
    public static func build<T: Factoryable>(using factory: FactorySwift<T>, with overrideBlock: @escaping () -> [Attribute]) -> Generator {
        return Generator { _ in try factory.build(with: overrideBlock) }
    }
    
    /// Create a Generator that returns value built using a passed factory
    public static func build<T: Factoryable>(using factory: FactorySwift<T>, with overrides: [Attribute] = []) -> Generator {
        return Generator { _ in try factory.build(with: overrides) }
    }

    /// Create a Generator that returns values built using a passed factory
    public static func build<T: Factoryable>(using factory: FactorySwift<T>, count: Int, with overrideBlock: @escaping () -> [Attribute]) -> Generator {
        return Generator { _ in try factory.build(count: count, with: overrideBlock) }
    }
    
    /// Create a Generator that returns values built using a passed factory
    public static func build<T: Factoryable>(using factory: FactorySwift<T>, count: Int, with overrides: [Attribute] = []) -> Generator {
        return Generator { _ in try factory.build(count: count, with: overrides) }
    }
}
