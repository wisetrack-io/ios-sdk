//
//  WebViewController.swift
//  WiseTrackLib
//
//  Created by Mostafa Movahhed on 3/6/1404 AP.
//  Copyright © 1404 AP CocoaPods. All rights reserved.
//

import UIKit
import WebKit
import WiseTrackLib

class WebViewController: UIViewController, WKScriptMessageHandler {
    var webView: WKWebView!
    
    //    var bridge: WiseTrackWebBridge!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let contentController = WKUserContentController()
        
        // Inject JS to override console.log and redirect to Swift
        let scriptSource = """
              (function() {
                  var console = window.console;
                  function sendToNative(level, args) {
                      try {
                          window.webkit.messageHandlers.consoleHandler.postMessage({ level: level, message: args.join(" ") });
                      } catch(e) {}
                  }
                  ['log', 'warn', 'error', 'info'].forEach(function (level) {
                      var original = console[level];
                      console[level] = function () {
                          sendToNative(level, Array.from(arguments));
                          original.apply(console, arguments);
                      }
                  });
              })();
              """
        
        let userScript = WKUserScript(source: scriptSource, injectionTime: .atDocumentStart, forMainFrameOnly: false)
        contentController.addUserScript(userScript)
        
        // Register handler to receive console logs
        contentController.add(self, name: "consoleHandler")
        
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        
        webView = WKWebView(frame: self.view.bounds, configuration: config)
        self.view.addSubview(webView)
        
        WiseTrackWebBridge.shared.register(webView)
        //        bridge = WiseTrackWebBridge(webView: webView)
        
        if let path = Bundle.main.path(forResource: "test.html", ofType: nil) {
            let url = URL(fileURLWithPath: path)
            webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
        }
    }
    
    // MARK: WKScriptMessageHandler
       func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
           guard message.name == "consoleHandler",
                 let body = message.body as? [String: Any],
                 let level = body["level"] as? String,
                 let msg = body["message"] as? String else {
               return
           }

           print("[JSConsole:\(level.uppercased())] \(msg)")
       }
}
