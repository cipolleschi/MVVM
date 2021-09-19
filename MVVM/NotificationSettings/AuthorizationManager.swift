//
//  AuthorizationManager.swift
//

import Foundation
import UserNotifications

// MARK: - Interface
protocol AuthorizationManager {
    func currentAuthorization(completion: @escaping (UNAuthorizationStatus) -> Void)
    func askAuthorization(completionHandler: @escaping (Bool, Error?) -> Void)
}

// MARK: - Live Implementation
class LiveAuthorizationManager: AuthorizationManager {
    
    let notificationCenter: UNUserNotificationCenter
    
    init(
        notificationCenter: UNUserNotificationCenter = .current()
    ) {
        self.notificationCenter = notificationCenter
    }
    
    func currentAuthorization(completion: @escaping (UNAuthorizationStatus) -> Void) {
        self.notificationCenter.getNotificationSettings { settings in
            completion(settings.authorizationStatus)
        }
    }
    
    func askAuthorization(completionHandler: @escaping (Bool, Error?) -> Void) {
        self.notificationCenter.requestAuthorization(
            options: [.badge, .sound, .alert],
            completionHandler: completionHandler
        )
    }
}
