import SwiftUI
import UIKit

extension Color {
    
    func darker(by factor: CGFloat = 0.92) -> Color {
        let ui = UIColor(self)
        
        var hue: CGFloat = 0
        var sat: CGFloat = 0
        var bri: CGFloat = 0
        var alpha: CGFloat = 0
        
        guard ui.getHue(
            &hue,
            saturation: &sat,
            brightness: &bri,
            alpha: &alpha
        ) else {
            return self
        }
        
        return Color(
            UIColor(
                hue: hue,
                saturation: sat,
                brightness: bri,
                alpha: alpha
            )
        )
    }
    
    func lighter(by factor: CGFloat = 1.3) -> Color {
        let ui = UIColor(self)
        
        var hue: CGFloat = 0
        var sat: CGFloat = 0
        var bri: CGFloat = 0
        var alpha: CGFloat = 0
        
        guard ui.getHue(
            &hue,
            saturation: &sat,
            brightness: &bri,
            alpha: &alpha
        ) else {
            return self
        }
        
        return Color(
            UIColor(
                hue: hue,
                saturation: sat,
                brightness: min(bri * factor, 1),
                alpha: alpha
            )
        )
    }
    
    static var greenLightIndicatorColor: Color {
        .init(uiColor: UIColor(red: 0.226, green: 1.000, blue: 0.226, alpha: 1.000))
    }
    
    static var orangeLightIndicatorColor: Color {
        .init(uiColor: UIColor(red: 1.000, green: 0.718, blue: 0.000, alpha: 1.000))
    }
}
