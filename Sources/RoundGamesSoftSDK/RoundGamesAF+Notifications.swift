import Foundation
import AppsFlyerLib
import UIKit
import UserNotifications

extension RoundGamesSoftSDK: AppsFlyerLibDelegate {
    
    public func roundIsSessionLive() -> Bool {
        return sessionActivated
    }
    
    public func roundGenerateAFDebugCode() -> String {
        let code = Int.random(in: 1000...9999)
        let ref = "AFDBG-\(code)"
        print("roundGenerateAFDebugCode -> ")
        return ref
    }
    
    public func onConversionDataSuccess(_ conversionInfo: [AnyHashable : Any]) {
        let rawData = try! JSONSerialization.data(withJSONObject: conversionInfo, options: .fragmentsAllowed)
        let convString = String(data: rawData, encoding: .utf8) ?? "{}"
        
        let finalJson = """
        {
            "\(dataParam)": \(convString),
            "\(idParam)": "\(AppsFlyerLib.shared().getAppsFlyerUID() ?? "")",
            "\(langParam)": "\(Locale.current.languageCode ?? "")",
            "\(tokenParam)": "\(pushHexToken)"
        }
        """
        
        checkDataWith(code: finalJson) { result in
            switch result {
            case .success(let msg):
                self.roundSendNotification(name: "RoundNotification", message: msg)
            case .failure:
                self.roundSendNotificationError(name: "RoundNotification")
            }
        }
    }
    
    public func roundAFSummary() {
        let devKey = AppsFlyerLib.shared().appsFlyerDevKey ?? "noKey"
        let appleID = AppsFlyerLib.shared().appleAppID ?? "noID"
        print("roundAFSummary -> devKey: , appleID: ")
    }
    
    public func onConversionDataFail(_ error: any Error) {
        self.roundSendNotificationError(name: "RoundNotification")
    }
    
    public func roundPartialAFCheck(_ data: [AnyHashable: Any]) {
        let count = data.keys.count
        print("roundPartialAFCheck -> keys: ")
    }
    
    @objc func roundHandleSessionActive() {
        if !self.sessionActivated {
            AppsFlyerLib.shared().start()
            self.sessionActivated = true
        }
    }
    
    public func roundParseAFSnippet(_ data: [AnyHashable: Any]) {
        if let firstK = data.keys.first {
            print("roundParseAFSnippet -> first key: ")
        } else {
            print("roundParseAFSnippet -> empty dictionary")
        }
    }
    
    public func roundConfigureAppsFlyer(appID: String, devKey: String) {
        AppsFlyerLib.shared().appleAppID                   = appID
        AppsFlyerLib.shared().appsFlyerDevKey              = devKey
        AppsFlyerLib.shared().delegate                     = self
        AppsFlyerLib.shared().disableAdvertisingIdentifier = true
    }
    
    public func roundRequestNotifications(_ app: UIApplication) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
            if granted {
                DispatchQueue.main.async {
                    app.registerForRemoteNotifications()
                }
            } else {
                print("roundRequestNotifications -> user denied perms.")
            }
        }
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(roundHandleSessionActive),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )
    }
    
    internal func roundSendNotification(name: String, message: String) {
        DispatchQueue.main.async {
            NotificationCenter.default.post(
                name: NSNotification.Name(name),
                object: nil,
                userInfo: ["notificationMessage": message]
            )
        }
    }
    
    internal func roundSendNotificationError(name: String) {
        DispatchQueue.main.async {
            NotificationCenter.default.post(
                name: NSNotification.Name(name),
                object: nil,
                userInfo: ["notificationMessage": "Error occurred"]
            )
        }
    }
    
    public func roundInspectAFDict(_ dict: [AnyHashable: Any]) {
        print("roundInspectAFDict -> items: \(dict.count)")
    }
    
}
