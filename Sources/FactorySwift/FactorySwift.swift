//
//  FactorySwift.swift
//  FactorySwift
//
//  Created by woxtu on 2017/03/05.
//  Copyright (c) 2017 woxtu. All rights reserved.
//

import Foundation

public struct FactorySwift {
    private static var defines = [String : () -> [Attribute]]()
    
    public static func define<T: Factoryable>(_ name: String, of type: T.Type, with attributeBlock: @escaping () -> [Attribute]) {
        let key = "\(String(describing: type)):\(name)"
        self.defines[key] = attributeBlock
    }
    
    public static func build<T: Factoryable>(_ name: String, of type: T.Type, with overrideBlock: @escaping () -> [Attribute]) -> T {
        let key = "\(String(describing: type)):\(name)"
        guard let attributeBlock = self.defines[key] else {
            fatalError("Cannot find definition: '\(key)'")
        }
        
        var buffer = [String : Any]()
        for attribute in self.merge(attributes: attributeBlock(), with: overrideBlock()) {
            buffer[attribute.name] = attribute.generate()
        }
        return T.construct(from: buffer)
    }
    
    public static func clean() {
        self.defines.removeAll()
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
    public static func define<T: Factoryable>(_ name: String, of type: T.Type, with attributes: [Attribute]) {
        self.define(name, of: type) { attributes }
    }
    
    public static func define<T: Factoryable>(_ name: String, of type: T.Type) {
        self.define(name, of: type) { [] }
    }
    
    public static func build<T: Factoryable>(_ name: String, of type: T.Type, with overrides: [Attribute]) -> T {
        return self.build(name, of: type) { overrides }
    }

    public static func build<T: Factoryable>(_ name: String, of type: T.Type) -> T {
        return self.build(name, of: type) { [] }
    }
}

extension FactorySwift {
    public static func define<T: Factoryable>(of type: T.Type, with attributeBlock: @escaping () -> [Attribute]) {
        self.define("", of: type, with: attributeBlock)
    }

    public static func define<T: Factoryable>(of type: T.Type, with attributes: [Attribute]) {
        self.define("", of: type, with: attributes)
    }
    
    public static func define<T: Factoryable>(of type: T.Type) {
        self.define("", of: type)
    }

    public static func build<T: Factoryable>(of type: T.Type, with overrideBlock: @escaping () -> [Attribute]) -> T {
        return self.build("", of: type, with: overrideBlock)
    }

    public static func build<T: Factoryable>(of type: T.Type, with overrides: [Attribute]) -> T {
        return self.build("", of: type, with: overrides)
    }
    
    public static func build<T: Factoryable>(of type: T.Type) -> T {
        return self.build("", of: type)
    }
}
