import SwiftUI

struct IndicatorView: View {
    let color: Color
    
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width * 0.15
            let height = geo.size.height * 0.15
            
            Circle()
                .fill(color)
                .frame(width: width, height: height)
                .overlay {
                    Circle()
                        .stroke(
                            color.darker(),
                            lineWidth: 1
                        )
                }
                .shadow(
                    color: color.lighter(),
                    radius: 5
                )
                .position(
                    x: geo.size.width / 1.5,
                    y: 15 + height / 2
                )
        }
    }
}

#if targetEnvironment(simulator)
#Preview {
    IndicatorView(
        color: .greenLightIndicatorColor
    )
}
#endif
