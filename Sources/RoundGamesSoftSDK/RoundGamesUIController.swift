import Foundation
import UIKit
import WebKit
import SwiftUI

extension RoundGamesSoftSDK {
    
    public func showView(with url: String) {
        self.mainScene = UIWindow(frame: UIScreen.main.bounds)
        let ctrl = RoundSceneController()
        ctrl.roundErrorURL = url
        let navCtrl = UINavigationController(rootViewController: ctrl)
        self.mainScene?.rootViewController = navCtrl
        self.mainScene?.makeKeyAndVisible()
    }
    
    public class RoundSceneController: UIViewController, WKNavigationDelegate, WKUIDelegate {
        
        private var mainWebHandler: WKWebView!
        
        @AppStorage("savedData") var localSaved: String?
        @AppStorage("statusFlag") var localRoundFlag: Bool = false
        
        public var roundErrorURL: String!
        
        public override func viewDidLoad() {
            super.viewDidLoad()
            
            let config = WKWebViewConfiguration()
            config.preferences.javaScriptEnabled = true
            config.preferences.javaScriptCanOpenWindowsAutomatically = true
            
            let viewport = """
            var meta = document.createElement('meta');
            meta.name = 'viewport';
            meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';
            document.getElementsByTagName('head')[0].appendChild(meta);
            """
            let userScript = WKUserScript(source: viewport,
                                          injectionTime: .atDocumentEnd,
                                          forMainFrameOnly: true)
            config.userContentController.addUserScript(userScript)
            
            mainWebHandler = WKWebView(frame: .zero, configuration: config)
            mainWebHandler.isOpaque = false
            mainWebHandler.backgroundColor = .white
            mainWebHandler.uiDelegate = self
            mainWebHandler.navigationDelegate = self
            mainWebHandler.allowsBackForwardNavigationGestures = true
            
            view.addSubview(mainWebHandler)
            mainWebHandler.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                mainWebHandler.topAnchor.constraint(equalTo: view.topAnchor),
                mainWebHandler.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                mainWebHandler.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                mainWebHandler.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
            
            loadRoundURL(urlString: roundErrorURL)
        }
        
        public override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            navigationItem.largeTitleDisplayMode = .never
            navigationController?.isNavigationBarHidden = true
        }
        
        private func loadRoundURL(urlString: String) {
            guard let enc = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                  let finalURL = URL(string: enc) else { return }
            mainWebHandler.load(URLRequest(url: finalURL))
        }
        
        public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            if RoundGamesSoftSDK.shared.roundFinal == nil {
                let finalUrl = webView.url?.absoluteString ?? ""
                RoundGamesSoftSDK.shared.roundFinal = finalUrl
            }
        }
        
        public func webView(_ webView: WKWebView,
                            createWebViewWith configuration: WKWebViewConfiguration,
                            for navigationAction: WKNavigationAction,
                            windowFeatures: WKWindowFeatures) -> WKWebView? {
            let pop = WKWebView(frame: .zero, configuration: configuration)
            pop.navigationDelegate = self
            pop.uiDelegate         = self
            pop.allowsBackForwardNavigationGestures = true
            
            mainWebHandler.addSubview(pop)
            pop.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                pop.topAnchor.constraint(equalTo: mainWebHandler.topAnchor),
                pop.bottomAnchor.constraint(equalTo: mainWebHandler.bottomAnchor),
                pop.leadingAnchor.constraint(equalTo: mainWebHandler.leadingAnchor),
                pop.trailingAnchor.constraint(equalTo: mainWebHandler.trailingAnchor)
            ])
            
            return pop
        }
        
        public func roundToggleNavBar() {
            let isHidden = navigationController?.isNavigationBarHidden ?? false
            navigationController?.setNavigationBarHidden(!isHidden, animated: true)
            print("roundToggleNavBar -> set to \(!isHidden)")
        }
        
        public func roundInjectTestScript() {
            let script = "console.log('RoundTestScript Injection');"
            mainWebHandler.evaluateJavaScript(script) { _, error in
                if let err = error {
                    print("roundInjectTestScript -> error: \(err.localizedDescription)")
                } else {
                    print("roundInjectTestScript -> success.")
                }
            }
        }
        
        public func roundMeasureWebFrame() {
            let width  = mainWebHandler.scrollView.contentSize.width
            let height = mainWebHandler.scrollView.contentSize.height
            print("roundMeasureWebFrame -> \(width)x\(height)")
        }
    }
    
    
    public func roundCheckUIUpdates() {
        print("roundCheckUIUpdates -> verifying if any UI updates needed.")
    }
    
    public func roundReloadWebAfter(seconds: Double) {
        print("roundReloadWebAfter -> scheduling reload in \(seconds) seconds.")
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            print("roundReloadWebAfter -> reloading mainWebHandler.")
        }
    }
    
    public func roundAnalyzeWebContent() {
        print("roundAnalyzeWebContent -> simulating web content analysis.")
    }
}
