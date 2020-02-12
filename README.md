# swift-checkit

Swift-checkit is a library containing validators which exercise common protocols.

This all started because I hit a bug recently: on one of my custom collections, incrementing startIndex by count returned nil, rather than the expected endIndex. I never noticed this before, because all of my real-world code incremented indices by +/-1, and never in steps larger than that. Nonetheless, there were expected, documented semantics and generic code was relying on that.

Swift's protocols aren't just bags of syntax; there is some expected behaviour attached to each of them. Sometimes those expectations can be reflected in the type-system, but sometimes they have to be explained in documentation and left to the programmer. That's fine - but as software becomes more complex, it's easy to make changes which accidentally violate some subtle semantics of the protocol. That's why we write tests.

Swift-checkit has some helpful pre-made tests to make that easier.

## Installation

Installation is via the Swift Package Manager. Simply add the package to your Package.swift, and add "Checkit" as a dependency for your test targets:

```swift
// Package.swift

let package = Package(...
    dependencies: [
        .package(url: "https://github.com/karwa/swift-checkit.git", .branch("master"))
    ],
    targets: [
        .testTarget(name: "MyTests", dependencies: ["Checkit"]),
    ]
    ...
)
```

Now all you need to write is:

```swift
// MyTests.swift
import Checkit
```

and you're good to start using the validators. How about checking if your custom `Collection` _really_ conforms to the protocol? Or whether your `Sequence`-constrained algorithm _really_ handles a single-pass `Sequence`? 

```swift
func testCollectionSemantics() {
  let myCustomCollection = MyCollection(...)
  CollectionChecker.check(myCustomCollection)
}

// in project:
// func myAlgorithm<S: Sequence>(with: S) { ... }

func testAlgorithm() {
  SinglePassSequenceChecker.check(0..<5) { sequence in myAlgorithm(sequence) }
}
```

---

## Contributing

Contributions welcome! Feel free to fork/add/send PRs for new checks and checkers!
