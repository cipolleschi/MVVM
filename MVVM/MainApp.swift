//
//  MainApp.swift
//

import SwiftUI

@main
struct MainApp: App {

    let authorizationManager = LiveAuthorizationManager()
    let settingsManager = LiveSettingsManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView(
                viewModel: .init(
                    settingsOpener: UIApplication.shared,
                    authorizationManager: self.authorizationManager,
                    settingsManager: self.settingsManager
                )
            )
        }
    }
}
