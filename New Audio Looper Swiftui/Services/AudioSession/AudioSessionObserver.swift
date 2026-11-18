import Foundation
import Combine

public protocol AudioSessionObserver: AnyObject {
    var eventPublisher: AnyPublisher<AudioSessionEvent, Never> { get }
}
