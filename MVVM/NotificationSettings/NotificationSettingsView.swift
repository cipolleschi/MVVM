//
//  NotificationSettingsView.swift
//

import SwiftUI

struct NotificationSettingsView: View {
    @StateObject var viewModel: NotificationSettingsViewModel
    @Environment(\.scenePhase) var scene
    
    var body: some View {
        Form {
            self.systemSettingsSection
            self.appSettingsSection
        }.onChange(of: scene, perform: { value in
            self.viewModel.refreshAuthorizationStatus()
        })
    }
    
    var systemSettingsSection: some View {
        Section(header: Text("System Setting")) {
            self.currentStatus
            if self.viewModel.isAskPermissionButtonVisible {
                self.askPermission
            }
            
            if self.viewModel.isOpenSettingsButtonVisible {
                self.openSetitngs
            }
        }
    }
    
    var currentStatus: some View {
        HStack {
            Text("Notification Status:")
            Text(self.viewModel.currentStatus)
                .font(.headline)
        }
    }
    
    var askPermission: some View {
        Button(
            action: self.viewModel.askPermissions,
            label: {
                Text("Ask user permission")
                    .frame(
                        maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                        alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/
                    )
            })
        
    }
    
    var openSetitngs: some View {
        Button(
            action: self.viewModel.openSettings,
            label: {
                Text("Open Settings")
                    .frame(
                        maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                        alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/
                    )
            })
    }
    
    var appSettingsSection: some View {
        Section(header: Text("App Setting")) {
            self.notificationEnabled
            if self.viewModel.isDatePickerVisible {
                self.remindAtPicker
            }
        }
    }
    
    var notificationEnabled: some View {
        Toggle(
            isOn: self.$viewModel.settingsManager.settings.notificationEnabledByUser,
            label: {
            Text("Notification Enabled:")
        })
        .disabled(!self.viewModel.isEnableNotificationToggleEnabled)
    }
    
    var remindAtPicker: some View {
        DatePicker(
            "Remind at:",
            selection: self.$viewModel.settingsManager.settings.remindAt,
            displayedComponents: .hourAndMinute
        )
        .disabled(!self.viewModel.isEnableNotificationToggleEnabled)
    }
}
