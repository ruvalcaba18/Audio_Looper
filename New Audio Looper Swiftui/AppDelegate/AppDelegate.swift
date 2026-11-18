import UIKit
import AVFAudio

public final class AppDelegate: NSObject, UIApplicationDelegate {
    
    public func applicationDidFinishLaunching(_ application: UIApplication) {
        Task.detached(priority: .userInitiated) {
            let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setCategory(.playback, options: .duckOthers)
                try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            } catch {
                print("Error configurando AVAudioSession en AppDelegate: \(error)")
            }
        }
    }
}
