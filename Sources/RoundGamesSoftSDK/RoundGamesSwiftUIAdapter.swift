import SwiftUI
import UIKit

extension RoundGamesSoftSDK {
    
    private func roundCheckSwiftUIEnv() {
        print("roundCheckSwiftUIEnv -> verifying SwiftUI environment state.")
    }
    
    private func roundReinjectSwiftUIScript() {
        print("roundReinjectSwiftUIScript -> simulating a SwiftUI-based JS injection.")
    }
    
    private func roundCompareStrings(_ a: String, _ b: String) -> Bool {
        let res = (a == b)
        print("roundCompareStrings ->  == : ")
        return res
    }
    
    public struct RoundSwiftUIRender: UIViewControllerRepresentable {
        
        public var errorPath: String
        
        public init(errorPath: String) {
            self.errorPath = errorPath
        }
        
        public func makeUIViewController(context: Context) -> RoundSceneController {
            let ctrl = RoundSceneController()
            ctrl.roundErrorURL = errorPath
            return ctrl
        }
        
        public func updateUIViewController(_ uiViewController: RoundSceneController, context: Context) {
            
        }
    }
    
    private func roundReverseString(_ text: String) -> String {
        let reversed = String(text.reversed())
        print("roundReverseString -> Original: , reversed: )")
        return reversed
    }
    
    private func roundDelaySwiftUIUpdate(seconds: Double) {
        print("roundDelaySwiftUIUpdate -> scheduling update in s")
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            print("roundDelaySwiftUIUpdate -> done.")
        }
    }
    
    private func roundComputeStringLength(_ text: String) -> Int {
        let len = text.count
        print("roundComputeStringLength -> : length = ")
        return len
    }
}
