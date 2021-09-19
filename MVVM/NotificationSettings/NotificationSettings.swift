//
//  NotificationSettings.swift
//

import Foundation

struct NotificationSettings: Codable {
    var notificationEnabledByUser: Bool
    var remindAt: Date
}
