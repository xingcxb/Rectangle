//
//  ApplicationToggle.swift
//  Rectangle
//
//  Created by Ryan Hanson on 6/18/19.
//  Copyright © 2019 Ryan Hanson. All rights reserved.
//

import Cocoa

class ApplicationToggle: NSObject {
    
    private var disabledApps = Set<String>()
    public private(set) var frontAppId: String?
    public private(set) var frontAppName: String?
    public private(set) var disabledForApp: Bool = false
    
    override init() {
        super.init()
        registerFrontAppChangeNote()
        if let disabledApps = getDisabledApps() {
            self.disabledApps = disabledApps
        }
    }
    
    private func saveDisabledApps() {
        let encoder = JSONEncoder()
        if let jsonDisabledApps = try? encoder.encode(disabledApps) {
            if let jsonString = String(data: jsonDisabledApps, encoding: .utf8) {
                Defaults.disabledApps.value = jsonString
            }
        }
    }
    
    private func getDisabledApps() ->  Set<String>? {
        guard let jsonDisabledAppsString = Defaults.disabledApps.value else { return nil }
        
        let decoder = JSONDecoder()
        guard let jsonDisabledApps = jsonDisabledAppsString.data(using: .utf8) else { return nil }
        guard let disabledApps = try? decoder.decode(Set<String>.self, from: jsonDisabledApps) else { return nil }
        
        return disabledApps
    }
    
    public func disableFrontApp() {
        if let frontAppId = self.frontAppId {
            disabledApps.insert(frontAppId)
            saveDisabledApps()
            self.disabledForApp = true
        }
    }
    
    public func enableFrontApp() {
        if let frontAppId = self.frontAppId {
            disabledApps.remove(frontAppId)
            saveDisabledApps()
            self.disabledForApp = false
        }
    }
    
    public func isDisabled(bundleId: String) -> Bool {
        return disabledApps.contains(bundleId)
    }
    
    private func registerFrontAppChangeNote() {
        NSWorkspace.shared.notificationCenter.addObserver(self, selector: #selector(self.receiveFrontAppChangeNote(_:)), name: NSWorkspace.didActivateApplicationNotification, object: nil)
    }
    
    @objc func receiveFrontAppChangeNote(_ notification: Notification) {
        if let application = notification.userInfo?["NSWorkspaceApplicationKey"] as? NSRunningApplication {
            self.frontAppId = application.bundleIdentifier
            self.frontAppName = application.localizedName
            if let frontAppId = application.bundleIdentifier {
                self.disabledForApp = isDisabled(bundleId: frontAppId)
            } else {
                self.disabledForApp = false
            }
        }
    }
    
}
