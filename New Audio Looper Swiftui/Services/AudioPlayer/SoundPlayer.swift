import Foundation

@MainActor
public protocol SoundPlayer: AnyObject {
    func configureAudioSession(for celebration: CelebrationModel) async throws
    func playInstrument(_ instrument: InstrumentsModel)
    func stopInstrument(_ instrument: InstrumentsModel)
    func stopAllInstruments()
    func updateRate(_ rate: Float, for instrument: InstrumentsModel)
    func updateVolume(_ volume: Float, for instrument: InstrumentsModel)
    
    func isPlaying(_ instrument: InstrumentsModel) -> Bool
    func volume(for instrument: InstrumentsModel) -> Float
    func rate(for instrument: InstrumentsModel) -> Float
}
