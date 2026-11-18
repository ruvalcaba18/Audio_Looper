import Foundation

public enum InstrumentsModel: String, CaseIterable, Identifiable {
    
    case guitar = "guitar"
    case clasicGuitar = "guitarra_clasica"
    case vihuela = "vihuela"
    case guitarron = "guitarron"
    case violin = "violin"
    case trompet = "trompeta"
    
    case thrillerBajoSynth = "thriller_bajo_synth"
    case thrillerBateria = "thriller_bateria"
    case thrillerSinteBrass = "thriller_sinte_brass"
    case thrillerPad = "thriller_pad"
    case thrillerEfectosHalloween = "thriller_efectos_halloween"
    
    case revAcordeon = "rev_acordeon"
    case revBajoSexto = "rev_bajo_sexto"
    case revTololoche = "rev_tololoche"
    case revRedoblante = "rev_redoblante"
    case revClarin = "rev_clarin"
    
    case navidadCampanitas = "navidad_campanitas"
    case navidadCascabeles = "navidad_cascabeles"
    case navidadPiano = "navidad_piano"
    case navidadBajo = "navidad_bajo"
    case navidadCuerdas = "navidad_cuerdas"
    
    public var id: String { rawValue }
    
    var resourceName: String { rawValue }
    
    public var displayName: String {
        switch self {
        case .guitar: return "Guitarra"
        case .clasicGuitar: return "Clásica"
        case .vihuela: return "Vihuela"
        case .guitarron: return "Guitarrón"
        case .violin: return "Violín"
        case .trompet: return "Trompeta"
        case .thrillerBajoSynth: return "Bajo Synth"
        case .thrillerBateria: return "Batería"
        case .thrillerSinteBrass: return "Synth Brass"
        case .thrillerPad: return "Pad"
        case .thrillerEfectosHalloween: return "Efectos"
        case .revAcordeon: return "Acordeón"
        case .revBajoSexto: return "Bajo Sexto"
        case .revTololoche: return "Tololoche"
        case .revRedoblante: return "Redoblante"
        case .revClarin: return "Clarín"
        case .navidadCampanitas: return "Campanitas"
        case .navidadCascabeles: return "Cascabeles"
        case .navidadPiano: return "Piano"
        case .navidadBajo: return "Bajo"
        case .navidadCuerdas: return "Cuerdas"
        }
    }

    public var instrumentImage: String {
        switch self {
        case .clasicGuitar:
            return "classic_guitar"
        default:
            return rawValue
        }
    }
}
