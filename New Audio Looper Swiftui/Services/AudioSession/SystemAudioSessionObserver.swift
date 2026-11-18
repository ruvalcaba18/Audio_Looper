import Foundation
import Combine
import AVFAudio

public final class SystemAudioSessionObserver: AudioSessionObserver {
    
    private let notificationCenter: NotificationCenter
    
    public init(notificationCenter: NotificationCenter = .default) {
        self.notificationCenter = notificationCenter
    }
    
    public var eventPublisher: AnyPublisher<AudioSessionEvent, Never> {
        let interruptionPublisher = notificationCenter
            .publisher(for: AVAudioSession.interruptionNotification, object: AVAudioSession.sharedInstance())
            .compactMap { [weak self] notification in
                self?.mapInterruption(notification)
            }
        
        let routeChangePublisher = notificationCenter
            .publisher(for: AVAudioSession.routeChangeNotification, object: AVAudioSession.sharedInstance())
            .compactMap { [weak self] notification in
                self?.mapRouteChange(notification)
            }
        
        return Publishers.Merge(interruptionPublisher, routeChangePublisher)
            .eraseToAnyPublisher()
    }
}

private extension SystemAudioSessionObserver {
    
    func mapInterruption(_ notification: Notification) -> AudioSessionEvent? {
        guard
            let value = notification.userInfo?[AVAudioSessionInterruptionTypeKey] as? UInt,
            let interruptionType = AVAudioSession.InterruptionType(rawValue: value)
        else {
            return nil
        }
        
        switch interruptionType {
        case .began:
            return .interruptionBegan
        case .ended:
            return .interruptionEnded
        @unknown default:
            return nil
        }
    }
    
    func mapRouteChange(_ notification: Notification) -> AudioSessionEvent? {
        guard
            let value = notification.userInfo?[AVAudioSessionRouteChangeReasonKey] as? UInt,
            let changeReason = AVAudioSession.RouteChangeReason(rawValue: value)
        else {
            return nil
        }
        
        switch changeReason {
        case .oldDeviceUnavailable, .override:
            return .headphonesDisconnected
        case .newDeviceAvailable:
            return .headphonesConnected
        default:
            return nil
        }
    }
}
