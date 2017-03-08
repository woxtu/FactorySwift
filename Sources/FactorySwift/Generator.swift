//
//  Generator.swift
//  FactorySwift
//
//  Created by woxtu on 2017/03/05.
//  Copyright (c) 2017 woxtu. All rights reserved.
//

import Foundation

public struct Generator {
    internal var apply: (Context) -> Any
    
    private init(apply: @escaping (Context) -> Any) {
        self.apply = apply
    }
    
    /// Create a Generator that returns generated value
    public static func generate(_ f: @escaping () -> Any) -> Generator {
        return Generator { _ in f() }
    }
    
    /// Create a Generator that returns fixed value
    public static func value(_ value: Any) -> Generator {
        return Generator { _ in value }
    }
    
    /// Create a Generator that returns sequential value
    public static func sequence(_ f: @escaping (Int) -> Any) -> Generator {
        return Generator { f($0.count) }
    }
    
    /// Create a Generator that returns value depends another attribute
    public static func depend(on name: String, _ f: @escaping (Any?) -> Any) -> Generator {
        return Generator { f($0.rawValues[name]) }
    }
    
    /// Create a Generator that returns value depends other attributes
    public static func depend(on names: [String], _ f: @escaping ([Any?]) -> Any) -> Generator {
        return Generator { context in f(names.map { context.rawValues[$0] }) }
    }
    
    /// Create a Generator that returns value random picked from passed sequence
    public static func pick<S: Sequence>(from sequence: S) -> Generator {
        let array = Array(sequence)
        return Generator { _ in array[Int(arc4random_uniform(UInt32(array.count)))] }
    }
}
