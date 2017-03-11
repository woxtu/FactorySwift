# FactorySwift

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

        // Genetate values picked from sequence
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

## License

Licensed under the MIT License.
