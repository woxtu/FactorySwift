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
    
    public static func define<T: Factoryable>(of type: T.Type, with defineBlock: @escaping () -> [Attribute]) -> FactorySwift {
        return FactorySwift(defineBlock: defineBlock)
    }
    
    public func build<T: Factoryable>(of type: T.Type, with overrideBlock: @escaping () -> [Attribute]) -> T {
        var buffer = [String : Any]()
        for attribute in FactorySwift.merge(attributes: self.defineBlock(), with: overrideBlock()) {
            buffer[attribute.name] = attribute.generate()
        }
        return T.construct(from: buffer)
    }
    
    private static func merge(attributes: [Attribute], with overrides: [Attribute]) -> [Attribute] {
        var buffer = attributes
        for override in overrides {
            if let index = (attributes.index { $0.name == override.name }) {
                buffer[index] = override
            }
        }
        return buffer
    }
}

extension FactorySwift {
    public static func define<T: Factoryable>(of type: T.Type, with attributes: [Attribute]) -> FactorySwift {
        return self.define(of: type) { attributes }
    }
    
    public static func define<T: Factoryable>(of type: T.Type) -> FactorySwift {
        return self.define(of: type) { [] }
    }
    
    public func build<T: Factoryable>(of type: T.Type, with overrides: [Attribute]) -> T {
        return self.build(of: type) { overrides }
    }

    public func build<T: Factoryable>(of type: T.Type) -> T {
        return self.build(of: type) { [] }
    }
}
