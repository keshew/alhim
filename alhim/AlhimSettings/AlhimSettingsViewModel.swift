import SwiftUI

class AlhimSettingsViewModel: ObservableObject {
    let contact = AlhimSettingsModel()
    @ObservedObject private var soundManager = SoundManager.shared
    
    @Published var isMusicOn: Bool {
        didSet {
            UserDefaults.standard.set(isMusicOn, forKey: "isMusicOn")
            soundManager.toggleMusic()
            NotificationCenter.default.post(name: Notification.Name("UserResourcesUpdated"), object: nil)
        }
    }
    
    init() {
        self.isMusicOn = UserDefaults.standard.bool(forKey: "isMusicOn")
    }
}
