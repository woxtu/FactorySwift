# FactorySwift

A factory library for building Swift objects inspired by [factory_girl](https://github.com/thoughtbot/factory_girl).

### Basic usage

```swift
struct Friend {
    let name: String
}

extension Friend : Factoryable {
    static func construct(from attributes: Attributes) throws -> Friend {
        return try Friend(name: attributes.value(forName: "name"))
    }
}

let factory = FactorySwift.define(type: Friend.self) {
    return [
        "name" => .value("Serval"),
    ]
}

let friend = try! factory.build()
```

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

### Override attributes

```swift
let friend = try! factory.build(type: Friend.self, with: [
    "name" => .value("Jaguar"),
])
```
