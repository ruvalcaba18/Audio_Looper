import SwiftUI

struct ControlKnob: View {
    
    private let maxAngle = 120.0
    private let scalingFactor = 4.0
    
    @Binding var value: Double
    @Binding var minimumValue: Double
    @Binding var maximumValue: Double
    @Binding var defaultValue: Double
    
    var indicatorColor = Color.white
    
    @State private var isHighlithed = false
    @State private var startValue = 0.0
    
    public init(
        value: Binding<Double>,
        minimumValue: Binding<Double>,
        maximumValue: Binding<Double>,
        defaultValue: Binding<Double>,
        indicatorColor: Color = Color.white
    ) {
        _value = value
        _minimumValue = minimumValue
        _maximumValue = maximumValue
        _defaultValue = defaultValue
        self.indicatorColor = indicatorColor
    }
    
    var body: some View {
        ZStack {
            KnobView(isHighlited: isHighlithed)
            
            IndicatorView(color: indicatorColor)
                .rotationEffect(.degrees(angle(for: value)))
                .animation(.easeInOut(duration: 0.2), value: value)
        }
        .gesture(dragGesture)
    }
}

private extension ControlKnob {
    
    var dragGesture: some Gesture {
        DragGesture()
            .onChanged { gesture in
                if !isHighlithed {
                    isHighlithed = true
                    startValue = value
                }
                
                let delta = -gesture.translation.height
                let currentAngle = angle(for: startValue)
                let newAngle = clampAngle(currentAngle + delta * scalingFactor)
                
                value = value(for: newAngle)
            }
            .onEnded { _ in
                isHighlithed = false
            }
    }
    
    func angle(for value: Double) -> Double {
        ((value - minimumValue) / (maximumValue - minimumValue) - 0.5) * (maxAngle * 2)
    }
    
    func value(for angle: Double) -> Double {
        (angle / (maxAngle * 2) + 0.5) * (maximumValue - minimumValue) + minimumValue
    }
    
    func clampAngle(_ angle: Double) -> Double {
        min(max(angle, -maxAngle), maxAngle)
    }
}

#if targetEnvironment(simulator)
#Preview {
    ControlKnob(
        value: .constant(0.5),
        minimumValue: .constant(-1.0),
        maximumValue: .constant(1.0),
        defaultValue: .constant(0.0)
    )
    .frame(width: 80, height: 80)
}
#endif
