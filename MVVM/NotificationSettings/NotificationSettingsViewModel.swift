//
//  NotificationSettingsViewModel.swift
//

import Combine
import UserNotifications

class NotificationSettingsViewModel: ObservableObject {
    @Published var settingsManager: SettingsManager
    @Published var currentAuthorizationStatus: UNAuthorizationStatus
    private let settingsOpener: SettingsOpener
    private let authorizationManager: AuthorizationManager
    
    init(
        settingsManager: SettingsManager,
        settingsOpener: SettingsOpener,
        authorizationManager: AuthorizationManager
    ) {
        self.settingsManager = settingsManager
        self.settingsOpener = settingsOpener
        self.authorizationManager = authorizationManager
        self.currentAuthorizationStatus = .notDetermined
        
        self.refreshAuthorizationStatus()
    }
    
    var currentStatus: String {
        switch self.currentAuthorizationStatus {
        case .authorized:
            return "Authorized"
        case .denied:
            return "Denied"
        case .ephemeral:
            return "Ephemeral"
        case .notDetermined:
            return "Not Determined"
        case .provisional:
            return "Provisional"
        @unknown default:
            return "Unknown"
        }
    }
    
    var isAskPermissionButtonVisible: Bool {
        return self.currentAuthorizationStatus == .notDetermined
    }
    
    var isEnableNotificationToggleEnabled: Bool {
        return self.currentAuthorizationStatus == .authorized
    }
    
    var isDatePickerVisible: Bool {
        return self.settingsManager.settings.notificationEnabledByUser
    }
    
    var isOpenSettingsButtonVisible: Bool {
        return ![UNAuthorizationStatus.notDetermined, UNAuthorizationStatus.authorized]
            .contains(self.currentAuthorizationStatus)
    }
    
    func refreshAuthorizationStatus() {
        self.authorizationManager.currentAuthorization { [weak self] status in
            DispatchQueue.main.async {
                self?.currentAuthorizationStatus = status
            }
        }
    }
    
    func askPermissions() {
        self.authorizationManager.askAuthorization { [weak self] success, _ in
            self?.refreshAuthorizationStatus()
        }
    }
    
    func openSettings() {
        self.settingsOpener.openSettings()
    }
}
