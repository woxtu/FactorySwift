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
    
    public static func generate(_ f: @escaping () -> Any) -> Generator {
        return Generator { _ in f() }
    }
}
