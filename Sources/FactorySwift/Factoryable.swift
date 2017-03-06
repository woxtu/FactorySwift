//
//  Factoryable.swift
//  FactorySwift
//
//  Created by woxtu on 2017/03/05.
//  Copyright (c) 2017 woxtu. All rights reserved.
//

import Foundation

public protocol Factoryable {
    static func construct(from attributes: Attributes) -> Self
}
