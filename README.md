# FactorySwift

[![CocoaPods](https://img.shields.io/cocoapods/v/FactorySwift.svg?style=flat-square)](https://cocoapods.org/pods/FactorySwift)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat-square)](https://github.com/Carthage/Carthage)
[![Swift Package Manager](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg?style=flat-square)](https://github.com/apple/swift-package-manager)

A factory library for building Swift objects inspired by [factory_girl](https://github.com/thoughtbot/factory_girl).

## Usage

```swift
struct Friend {
    let name: String
}

extension Friend : Factoryable {
    static func construct(from attributes: Attributes) throws -> Friend {
        return try Friend(name: attributes |> "name")
    }
}

let factory = FactorySwift.define(type: Friend.self, with: [
    "name": .value("Serval"),
])

let friend = try! factory.build()
// Friend(name: "Serval")
```

### Defining factories

```swift
// You can pass closures instead of dictionaries
let factory = FactorySwift.define(type: Friend.self) {
    // Set transient values
    let isCat = true

    return [
        // Generate fixed values
        "name": .value("Serval"),

        // Generate values from a passed closure
        "createdAt": .generate { NSDate() },

        // Generate sequential values
        "id": .sequence { $0 },

        // Generate values picked from sequence
        "age": .pick(from: 0 ..< 100),

        // Generate values using other factories
        "role": .build(using: roleFactory),
    ]
}
```

### Building objects

```swift
// Building a object
let friend = try! factory.build()

// Building a object and overriding attributes
let friend = try! factory.build(with: [
    "name": .value("Jaguar"),
])

// Building multiple objects
let friends = try! factory.build(count: 3)
```

## Installation

### CocoaPods

```
pod 'FactorySwift', '~> 0.1.0'
```

### Carthage

```
github "FactorySwift" ~> 0.1.0
```

### Swift Package Manager

```
.Package(url: "https://github.com/woxtu/FactorySwift.git", majorVersion: 0, minor: 1)
```

## License

Licensed under the MIT License.
