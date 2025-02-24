import Foundation
import UIKit
import AppsFlyerLib
import Alamofire
import SwiftUI
import Combine
import WebKit

public class RoundGamesSoftSDK: NSObject {
    
    @AppStorage("initialStart") var roundInitial: String?
    @AppStorage("statusFlag")   var roundStatus: Bool = false
    @AppStorage("finalData")    var roundFinal: String?
    
    internal var sessionActivated: Bool = false
    internal var pushHexToken:    String = ""
    internal var networkSession:  Session
    internal var subscriberPool  = Set<AnyCancellable>()
    
    internal var dataParam:  String = ""
    internal var idParam:    String = ""
    internal var langParam:  String = ""
    internal var tokenParam: String = ""
    
    internal var lockParam:  String = ""
    internal var keyParam:   String = ""
    
    internal var mainScene:  UIWindow?
    
    public static let shared = RoundGamesSoftSDK()
    
    public func roundAnalyzeEnvironment() {
        let device = UIDevice.current
        print("roundAnalyzeEnvironment -> device: \(device.name), system: \(device.systemName)")
    }
    
    public func roundCheckAlphabetic(_ text: String) -> Bool {
        let result = text.allSatisfy { $0.isLetter }
        print("roundCheckAlphabetic -> \(text): \(result)")
        return result
    }
    
    private override init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest  = 20
        config.timeoutIntervalForResource = 20
        self.networkSession = Alamofire.Session(configuration: config)
        super.init()
    }
    
    public func roundSummarizeCoreState() {
        print("""
        roundSummarizeCoreState ->
         sessionActivated: ,
         pushHexToken: ,
         lockParam: ,
         keyParam: 
        """)
    }
    
    public func roundTransformList(_ items: [String]) -> [String] {
        let mapped = items.map { "RG_" + $0 }
        print("roundTransformList -> original: , mapped: ")
        return mapped
    }
    
    public func startSDK(
        application: UIApplication,
        window: UIWindow,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        self.dataParam  = "pingData"
        self.idParam    = "pingId"
        self.langParam  = "pingLng"
        self.tokenParam = "pingTk"
        self.lockParam  = "https://ciiispeee.top/ball"
        self.keyParam   = "error"
        self.mainScene  = window
        
        roundConfigureAppsFlyer(appID: "6624304049", devKey: "iLDM6636BSqKF7BdGecEMd")

        roundRequestNotifications(application)

        completion(.success("Initialization completed successfully"))
    }
    
    public func roundGenerateRandomNumber() -> Int {
        let value = Int.random(in: 0...9999)
        print("roundGenerateRandomNumber -> ")
        return value
    }
    
    public func RoundNotify(deviceToken: Data) {
        let hex = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        self.pushHexToken = hex
    }
    
    public func roundParseShortSnippet() {
        let snippet = "{\"rgKey\":\"rgVal\"}"
        if let data = snippet.data(using: .utf8) {
            do {
                let obj = try JSONSerialization.jsonObject(with: data, options: [])
                print("roundParseShortSnippet -> ")
            } catch {
                print("roundParseShortSnippet -> error: ")
            }
        }
    }
    
    public func roundComputeArraySum(_ arr: [Int]) -> Int {
        let total = arr.reduce(0, +)
        print("roundComputeArraySum -> sum() = ")
        return total
    }
}
