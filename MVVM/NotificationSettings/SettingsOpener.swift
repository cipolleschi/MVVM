//
//  Protocols.swift
//

import UIKit

// MARK: - Interface
protocol SettingsOpener {
    func openSettings()
}

// MARK: - Implementation
extension UIApplication: SettingsOpener {
    func openSettings() {
        guard
            let url = URL(string: UIApplication.openSettingsURLString+Bundle.main.bundleIdentifier!),
            self.canOpenURL(url)
        else {
            return
        }
        
        self.open(url, options: [:])
    }
}
