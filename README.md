# Proveng2

**Tech stack:**
- `IOS 11.0`, `Swift 4`
- Carthage dependency manager:   `Alamofire v4.5.0`,  `ObjectMappe v2.2.8`,  `PromiseKit v4.3.2`,  `RealmSwift  v2.9.1` ...
- Static analyzers:   `tailor`,  `swiftlint`

**Instructions:**

- Static analyzers: to use static analyzers you need to install them on your machine using [Homebrew](http://brew.sh/):

```
brew install swiftlint
```

```
brew install tailor
```

To update Carthage dependencies, use following command to build dependencies with your compiler (avoiding versions mismatch)

```
carthage update --no-use-binaries
```
