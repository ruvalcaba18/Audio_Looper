import SwiftUI

@main
struct New_Audio_Looper_SwiftuiApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            JuckeboxTabView()
        }
    }
}
