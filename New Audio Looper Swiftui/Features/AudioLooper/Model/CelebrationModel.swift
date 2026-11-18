import Foundation

public enum CelebrationModel: String, CaseIterable, Identifiable {
    case septiembre16 = "16 de Septiembre"
    case octubre31 = "31 de Octubre"
    case noviembre20 = "20 de Noviembre"
    case diciembre25 = "25 de Diciembre"
    
    public var id: String { rawValue }
    
    public var title: String { rawValue }
    
    public var instruments: [InstrumentsModel] {
        switch self {
        case .septiembre16:
            return [.guitar, .clasicGuitar, .vihuela, .guitarron, .violin, .trompet]
        case .octubre31:
            return [.thrillerBajoSynth, .thrillerBateria, .thrillerSinteBrass, .thrillerPad, .thrillerEfectosHalloween]
        case .noviembre20:
            return [.revAcordeon, .revBajoSexto, .revTololoche, .revRedoblante, .revClarin]
        case .diciembre25:
            return [.navidadCampanitas, .navidadCascabeles, .navidadPiano, .navidadBajo, .navidadCuerdas]
        }
    }
}
