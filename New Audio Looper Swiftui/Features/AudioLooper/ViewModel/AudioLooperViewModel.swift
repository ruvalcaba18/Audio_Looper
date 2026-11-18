import Foundation
import Combine

public final class AudioLooperViewModel: ObservableObject {
 
    public var choosedCelebration: CelebrationModel = .septiembre16
    private let soundPlayerService: SoundPlayer
    private let audioSessionObserver: AudioSessionObserver
    private var cancellables = Set<AnyCancellable>()
    
    var hasAnyActiveInstrument: Bool {
        choosedCelebration.instruments.contains { soundPlayerService.isPlaying($0) }
    }
    
    @Published public private(set) var soundPlayerState: PlaybackStatus = .idle
    
    public init(
        soundPlayerService: SoundPlayer = SoundPlayerService(),
        audioSessionObserver: AudioSessionObserver = SystemAudioSessionObserver()
    ) {
        self.soundPlayerService = soundPlayerService
        self.audioSessionObserver = audioSessionObserver
        bindAudioSessionEvents()
    }
}

extension AudioLooperViewModel {
    
    func configureCelebrationInstruments(choosedCelebration: CelebrationModel,) async {
        self.choosedCelebration = choosedCelebration
        
        do {
            try await soundPlayerService.configureAudioSession(for: choosedCelebration)
            transition(to: .ready)
        } catch {
            transition(to: .failed(error.localizedDescription))
        }
    }
    
    @MainActor
    func playInstrument(_ instrument: InstrumentsModel) {
        soundPlayerService.playInstrument(instrument)
        transition(to: .playing)
    }
    
    @MainActor
    func stopInstrument(_ instrument: InstrumentsModel) {
        soundPlayerService.stopInstrument(instrument)
        transition(to: hasAnyActiveInstrument ? .playing : .stopped)
    }
    
    @MainActor
    func stopAll() {
        soundPlayerService.stopAllInstruments()
        transition(to: .stopped)
    }
    
    @MainActor
    public func updateRate(_ rate: Float, for instrument: InstrumentsModel) {
        soundPlayerService.updateRate(rate, for: instrument)
    }
    
    @MainActor
    public func updateVolume(_ volume: Float, for instrument: InstrumentsModel) {
        soundPlayerService.updateVolume(volume, for: instrument)
    }
    
    func isPlaying(_ instrument: InstrumentsModel) -> Bool {
        soundPlayerService.isPlaying(instrument)
    }
    
    func volume(for instrument: InstrumentsModel) -> Double {
        Double(soundPlayerService.volume(for: instrument))
    }
    
    func rate(for instrument: InstrumentsModel) -> Double {
        Double(soundPlayerService.rate(for: instrument))
    }
}

private extension AudioLooperViewModel {
    
    func transition(to newState: PlaybackStatus) {
        guard soundPlayerState != newState else { return }
        
        soundPlayerState = newState
    }
    
    func bindAudioSessionEvents() {
        audioSessionObserver.eventPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                guard let self else { return }
                
                handleAudioSessionEvent(event)
            }
            .store(in: &cancellables)
    }
    
    func handleAudioSessionEvent(_ event: AudioSessionEvent) {
        switch event {
        case .interruptionBegan:
            soundPlayerService.stopAllInstruments()
            transition(to: .interrupted)
            
        case .interruptionEnded:
            transition(to: .ready)
            
        case .headphonesDisconnected:
            soundPlayerService.stopAllInstruments()
            transition(to: .stopped)
            
        case .headphonesConnected:
            if soundPlayerState == .stopped || soundPlayerState == .interrupted {
                transition(to: .ready)
            }
        }
    }
}
