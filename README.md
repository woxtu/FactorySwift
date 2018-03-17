# FactorySwift

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat-square)](https://github.com/Carthage/Carthage)
[![CocoaPods](https://img.shields.io/cocoapods/v/FactorySwift.svg?style=flat-square)](https://cocoapods.org/pods/FactorySwift)
[![Swift Package Manager](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg?style=flat-square)](https://github.com/apple/swift-package-manager)

A factory library for building Swift objects inspired by [factory_bot](https://github.com/thoughtbot/factory_bot).

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

## Usage

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
        "createdAt": .generate { Date() },

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
// Building an object
let friend = try! factory.build()

// Building an object and overriding attributes
let friend = try! factory.build(with: [
    "name": .value("Jaguar"),
])

// Building multiple objects
let friends = try! factory.build(count: 3)
```

## Installation

### Carthage

```
github "FactorySwift" ~> 0.1
```

### CocoaPods

```
pod 'FactorySwift', '~> 0.1'
```

### Swift Package Manager

```
.package(url: "https://github.com/woxtu/FactorySwift.git", from: "0.1.0")
```

## License

Licensed under the MIT License.
