import Foundation
import AVFAudio

public final class SoundPlayerService: SoundPlayer {
  
    private var players: [InstrumentsModel: AVAudioPlayer] = [:]
    
    public init() {}
    
    public func configureAudioSession(for celebration: CelebrationModel) async throws {
        stopAllInstruments()
        players.removeAll()
        
        for instrument in celebration.instruments {
            let audioPlayer = try await createAudioPlayerSession(forResource: instrument.resourceName)
            players[instrument] = audioPlayer
        }
    }
    
    @MainActor
    public func playInstrument(_ instrument: InstrumentsModel) {
        guard let audioInstrumentPlayer = players[instrument], !audioInstrumentPlayer.isPlaying else {
            return
        }
        
        if let activePlayer = players.values.first(where: { $0.isPlaying }) {
            audioInstrumentPlayer.currentTime = activePlayer.currentTime
        }
        
        audioInstrumentPlayer.play()
    }
    
    public func stopInstrument(_ instrument: InstrumentsModel) {
        guard let audioInstrumentPlayer = players[instrument], audioInstrumentPlayer.isPlaying else {
            return
        }
        
        audioInstrumentPlayer.stop()
        audioInstrumentPlayer.currentTime = 0.0
    }
    
    public func stopAllInstruments() {
        for player in players.values where player.isPlaying {
            player.stop()
            player.currentTime = 0.0
        }
    }
    
    public func updateRate(_ rate: Float, for instrument: InstrumentsModel) {
        guard let audioInstrumentPlayer = players[instrument] else {
            return
        }
        
        audioInstrumentPlayer.rate = rate
    }
    
    public func updateVolume(_ volume: Float, for instrument: InstrumentsModel) {
        guard let audioInstrumentPlayer = players[instrument] else {
            return
        }
        
        audioInstrumentPlayer.volume = volume
    }
    
    public func isPlaying(_ instrument: InstrumentsModel) -> Bool {
        players[instrument]?.isPlaying ?? false
    }
    
    public func volume(for instrument: InstrumentsModel) -> Float {
        players[instrument]?.volume ?? 1.0
    }
    
    public func rate(for instrument: InstrumentsModel) -> Float {
        players[instrument]?.rate ?? 1.0
    }
}

private extension SoundPlayerService {
    
    func createAudioPlayerSession(forResource name: String) async throws -> AVAudioPlayer {
        let resourceURL = Bundle.main.url(forResource: name, withExtension: "wav")
        
        guard let resource = resourceURL else {
            throw SoundPlayerErrors.resourceDontFound
        }
        
        return try await Task.detached(priority: .userInitiated) {
            
            let audioPlayer = try AVAudioPlayer(contentsOf: resource)
            audioPlayer.numberOfLoops = -1
            audioPlayer.enableRate = true
            audioPlayer.prepareToPlay()
            
            return audioPlayer
        }.value
    }
}
