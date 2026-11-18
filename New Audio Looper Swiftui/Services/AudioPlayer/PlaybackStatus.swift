import Foundation

public enum PlaybackStatus: Equatable {
    case idle
    case ready
    case playing
    case stopped
    case interrupted
    case failed(String)
    
    public var isPlaying: Bool {
        self == .playing
    }
    
    public var isReady: Bool {
        self == .ready || self == .stopped
    }
    
    public var canPlay: Bool {
        switch self {
        case .ready, .playing, .stopped, .interrupted:
            return true
        case .idle, .failed:
            return false
        }
    }
}
