//
//  SettingsManager.swift
//

import Foundation

// MARK: - Protocol
protocol SettingsManager {
    var settings: NotificationSettings { get set }
}

// MARK: - Live Implementation
class LiveSettingsManager: SettingsManager {
    
    static let settingsKey = "NotificationSettings"
    
    let storage: UserDefaults
    var settings: NotificationSettings {
        get {
            return storage.get(
                NotificationSettings.self,
                for: Self.settingsKey,
                default: .init(notificationEnabledByUser: true, remindAt: Date())
            )
        }
        set {
            self.storage.setCodable(newValue, for: Self.settingsKey)
        }
    }
    
    init(storage: UserDefaults = .standard) {
        self.storage = storage
    }
}

// MARK: - User Defaults extension
extension UserDefaults {
    func get<T: Codable>(_ type: T.Type, for key: String) -> T? {
        guard let data = self.data(forKey: key) else {
            return nil
        }
        return try? JSONDecoder().decode(T.self, from: data)
    }
    
    func get<T: Codable>(_ type: T.Type, for key: String, default: T) -> T {
        guard
            let data = self.data(forKey: key),
            let retrieved = try? JSONDecoder().decode(T.self, from: data)
        else {
            return `default`
        }
        return retrieved
    }
    
    func setCodable<T: Codable>(_ value: T, for key: String) {
        let encoded = try? JSONEncoder().encode(value)
        self.setValue(encoded, forKey: key)
    }
}
