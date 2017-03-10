# FactorySwift

A factory library for building Swift objects inspired by [factory_girl](https://github.com/thoughtbot/factory_girl).

## Basic usage

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
    "name" => .value("Serval"),
])

let friend = try! factory.build()
```

## Defining factories

### Dynamic attributes

```swift
let factory = FactorySwift.define(type: Friend.self, with: [
    // ...
    "createdAt" => .generate { NSDate() },
])
```

### Transient attributes

```swift
let factory = FactorySwift.define(type: Friend.self) {
    let isCat = true
    return [
        "name" => .value("Serval \(isCat ? " cat" : "")"),
    ];
}
```

### Sequences

```swift
let factory = FactorySwift.define(type: Friend.self, with: [
    "name" => .sequence { "friend\($0)" },
])
```

### Using factory attributes

```swift
let factory = FactorySwift.define(type: Friend.self, with: [
    // ...
    "anotherClass" => .build(using: anotherFactory),
])
```

## Building objects

### Building object and override attributes

```swift
let friend = try! factory.build(with: [
    "name" => .value("Jaguar"),
])
```

### Building multiple objects

```swift
let friends = try! factory.build(count: 3)
```
