import SwiftUI

/// A `View` that encapsulates values which will be used to perform an animation on
/// a specified modifier.
///
/// You can override modifiers by adding extensions to the `View` protocol.
/// For example, adding a ``View/scaleEffect(_:)`` modifier that will simply
/// use the value provided by ``AnimatedView/viewModification: (T) -> Content``
/// view builder to scale targeted `View` according to the value handled over a specified animation time.
///
///     extension View {
///         func scaleEffect(
///             from initialValue: CGFloat, to finalValue: CGFloat, into seconds: Double
///         ) -> some View {
///             return AnimatedView(initialValue, finalValue, .easeOut(duration: seconds)) {
///                 scaleEffect($0).toAnyView()
///             }
///         }
///     }
///
///     Text("Hello, World!")
///         .scaleEffect(from: 0.2, to: 1.0, into: 5.0)
///
/// The ``Text`` instance in the example above will start to grow from 0.2 to 1 in 5 seconds.
/// 
public struct AnimatedView<T: Any, Content: View>: View {
    @State private var value: T
    private let finalValue: T
    private let animation: Animation
    @ViewBuilder private let viewModification: (T) -> Content
    
    public init(
        _ initialValue: T,
        _ finalValue: T,
        _ animation: Animation,
        @ViewBuilder _ viewModification: @escaping (T) -> Content
    ) {
        self._value = State(initialValue: initialValue)
        self.finalValue = finalValue
        self.animation = animation
        self.viewModification = viewModification
    }
    
    public var body: some View {
        viewModification(value)
            .onAppear {
                withAnimation(animation) {
                    value = finalValue
                }
            }
    }
}

public extension View {
    private func screenWidth() -> CGFloat { UIScreen.main.bounds.size.width }
    
    @ViewBuilder private func padding(
        leading: CGFloat,
        trailing: CGFloat = 0,
        top: CGFloat = 0,
        bottom: CGFloat = 0
    ) -> some View {
        self.padding(
            EdgeInsets(
                top: top,
                leading: leading,
                bottom: bottom,
                trailing: trailing
            )
        )
    }
    
    func slideInLeft(duration: Double) -> some View {
        AnimatedView(-screenWidth(), 0, .linear(duration: duration)) { padding(leading: $0, trailing: -$0) }
    }
    
    func slideInRight(duration: Double) -> some View {
        AnimatedView(screenWidth(), 0, .linear(duration: duration)) { padding(leading: $0, trailing: -$0) }
    }

    func fadeIn(duration: Double) -> some View {
        AnimatedView(0.0, 1, .linear(duration: duration)) { opacity($0) }
    }

    func slideOutLeft(duration: Double) -> some View {
        AnimatedView(0, -screenWidth(), .linear(duration: duration)) { padding(leading: $0, trailing: -$0) }
    }
    
    func slideOutRight(duration: Double) -> some View {
        AnimatedView(0, screenWidth(), .linear(duration: duration)) { padding(leading: $0, trailing: -$0) }
    }
    
    func fadeOut(duration: Double) -> some View {
        AnimatedView(1, 0.0, .linear(duration: duration)) { opacity($0) }
    }
}
