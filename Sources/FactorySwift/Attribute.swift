//
//  Attribute.swift
//  FactorySwift
//
//  Created by woxtu on 2017/03/05.
//  Copyright (c) 2017 woxtu. All rights reserved.
//

import Foundation

public struct Attribute {
    let name: String
    let generator: Generator
    
    public func generate() -> Any {
        return self.generator.apply()
    }
}

infix operator =>

func => (name: String, generator: Generator) -> Attribute {
    return Attribute(name: name, generator: generator)
}
