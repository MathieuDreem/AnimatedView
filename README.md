# AnimatedView

![Swift](https://img.shields.io/badge/Swift-5.x-orange)

🤩 Super Lightweight way to easily animate SwitUI Views.

## Introduction

`AnimatedView` is a simple `View` that encapsulates values which will be used to perform an animation on
 a specified modifier. It is designed to be used within `View` extensions (see the example below).
 
 You simply add an initialValue, a finalValue, the animation that should be performed 
 and the modifier you want the value interact with.

## Usage Example

For example, adding a `View/scaleEffect(_:)` modifier that will simply
use the value provided by `AnimatedView/viewModification: (T) -> Content`
view builder to scale targeted `View` according to the value handled over a specified animation time.

```swift
 extension View {
     func scaleEffect(
         from initialValue: CGFloat, to finalValue: CGFloat, into seconds: Double
     ) -> some View {
         return AnimatedView(initialValue, finalValue, .easeOut(duration: seconds)) {
             scaleEffect($0).toAnyView()
         }
     }
 }
```

Just like in the `GrowingText` example below :

```swift

private struct GrowingText: View {
    let text: String
    
    init(text: String = "Hello, World!") {
        self.text = text
    }
    
    var body: some View {
        Text("Hello, World!")
            .scaleEffect(from: 0.2, to: 1, into: 5)
    }
}

```
By calling this `View/scaleEffect(_:)` extension, the ``Text`` instance will 
start growing from 20% of its base frame size to 100% in 5 seconds.


As AnimatedView properties are Generic, you could even go fancy.

```swift

private struct ColorScaleOpacity {
    let color: Color
    let scale: CGFloat
    let opacity: Double
}

private struct FancyGrowingText: View {
    let text: String
    let from = ColorScaleOpacity(color: .blue, scale: 0.5, opacity: 0.0)
    let to = ColorScaleOpacity(color: .red, scale: 1, opacity: 1.0)
    
    init(text: String = "Hello, World!") {
        self.text = text
    }
    
    var body: some View {
        AnimatedView(from, to, .easeOut(duration: 5)) { value in
            Text("Hello, World!")
                .scaleEffect(value.scale)
                .foregroundColor(value.color)
                .opacity(value.opacity)
        }
    }
}

```

## Installation

- **Using  [CocoaPods](https://cocoapods.org)**:

    ```ruby
    pod 'AnimatedView'
    ```

- **Using [Swift Package Manager](https://swift.org/package-manager)**:

    ```swift
    import PackageDescription

    let package = Package(
        name: "YourPackage",
        dependencies: [
            .package(name: "AnimatedView", url: "https://github.com/MathieuDreem/AnimatedView.git", .upToNextMajor(from: "1.0.0")),
      ]
    )
    ```

## License

**AnimatedView** is under MIT license. See the [LICENSE](LICENSE) file for more info.
