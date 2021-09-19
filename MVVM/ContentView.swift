//
//  ContentView.swift
//

import SwiftUI

class ContentViewViewModel: ObservableObject {
    var settingsOpener: SettingsOpener
    var authorizationManager: AuthorizationManager
    var settingsManager: SettingsManager
    
    init(
        settingsOpener: SettingsOpener,
        authorizationManager: AuthorizationManager,
        settingsManager: SettingsManager
    ) {
        self.settingsOpener = settingsOpener
        self.authorizationManager = authorizationManager
        self.settingsManager = settingsManager
    }
    
    var notificationSettingsViewModel: NotificationSettingsViewModel {
        return NotificationSettingsViewModel(
            settingsManager: self.settingsManager,
            settingsOpener: self.settingsOpener,
            authorizationManager: self.authorizationManager
        )
    }
}

struct ContentView: View {
    
    @StateObject var viewModel: ContentViewViewModel
    
    
    var body: some View {
        TabView {
            Text("Hello World")
                .tabItem { Text("Home") }
            
            NotificationSettingsView(
                viewModel: self.viewModel.notificationSettingsViewModel
            )
            .tabItem { Text("Settings") }
        }
    }
}
