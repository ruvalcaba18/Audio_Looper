import SwiftUI

public struct KnobView: View {
    
    var isHighlited = false
    
    public init(isHighlited: Bool = false) {
        self.isHighlited = isHighlited
    }
    
    private var gradientLightColor: Color {
        isHighlited ? Color(red: 0.101, green: 0.100, blue: 0.103).darker() : Color(red: 0.101, green: 0.100, blue: 0.103)
    }
    
    private var gradientDarkColor: Color {
        isHighlited ? Color(red: 0.237, green: 0.242, blue: 0.242).darker() : Color(red: 0.237, green: 0.242, blue: 0.242)
    }
    
    public var body: some View {
        GeometryReader { geo in
            let size = min(geo.size.width, geo.size.height)
            
            ZStack {
                Circle()
                    .fill(Color(white: 0.06))
                    .padding(2)
                
                Circle()
                    .fill(Color(white: 0.06))
                    .padding(2)
                    .shadow(
                        color: .gray.opacity(0.8),
                        radius: 2,
                        x: 0,
                        y: 0.5
                    )
                
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [
                                gradientDarkColor,
                                gradientLightColor
                            ],
                            startPoint: .bottom,
                            endPoint: .top
                        )
                    )
                    .padding(5)
            }
            .frame(width: size, height: size)
        }
    }
}

#if targetEnvironment(simulator)
#Preview(".isHighlited") {
    KnobView(isHighlited: true)
}

#Preview(".isNotHighlited") {
    KnobView()
}
#endif
