//
//  AppDelegate.swift
//  WiseTrackLib
//
//  Created by 29954885 on 01/11/2025.
//  Copyright (c) 2025 29954885. All rights reserved.
//

import UIKit
import WiseTrackLib

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
//        WiseTrack.shared.enableTestMode()
        
        // add WT.StoreName key to Info.plist if you want seprate your publish
        
        if isTestRunning {
            WiseTrack.shared.enableTestMode()
        }

        // set log level
        WiseTrack.shared.setLogLevel(.debug)
        
        //initial
        ResourceWrapper.setSdkEnvironment(env: "stage")
        let config = WTInitialConfig(
            appToken: "rMN5ZCwpOzY7",
            storeName: .other,
//            storeName: .custom("asghar_store"),
            environment: .sandbox,
            logLevel: .debug,
            trackingWaitingTime: 5,
            startTrackerAutomatically: true,
            customDeviceId: "custom-device-id",
//                defaultTracker: "default",
            appSecret: "app-secret",
            secretId: "secret-id"
        )
//        WiseTrack.shared.initialize(with: config)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = WebViewController()
//        window!.makeKeyAndVisible()
        
//        WiseTrack.shared.setupHeatMap(window: &window!)
        
//        WiseTrack.shared.setupHeatMapTouchs()
        
        
//        SentrySDK.start { options in
//              options.dsn = "https://ce0a813b03eea839ff5b3df3517b8123@o1311679.ingest.us.sentry.io/4509185260257280"
//              options.debug = false // Enabling debug when first installing is always helpful
//              options.sendDefaultPii = true
//          }
        
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
        // request to ATT for IDFA (NOTE: add Info.plist setting [NSUserTrackingUsageDescription])
        WiseTrack.shared.requestAppTrackingAuthorization { isAuthorized in
//             call startTracking() if set startTrackerAutomatically to false
//            WiseTrack.shared.startTracking()
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        WiseTrack.shared.setAPNSToken(token: token)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print("open application with link = \(url.absoluteString)")
//        handleDeepLink(launchOptions: options)
        
        return true
    }
    
    var isTestRunning: Bool {
        get {
            return ProcessInfo.processInfo.environment["XCTestSessionIdentifier"] != nil
        }
    }
}





extension AppDelegate {
    
    private func handleDeepLink(launchOptions: [AnyHashable : Any]?) -> URL?{
        guard let options = launchOptions else {
            return nil
        }
        
        // Custom URL
        if let url = options[UIApplication.LaunchOptionsKey.url] as? URL {
            return url
        }
        
        // Universal link
        else if let activityDictionary = options[UIApplication.LaunchOptionsKey.userActivityDictionary] as? [AnyHashable: Any] {
            for key in activityDictionary.keys {
                if let userActivity = activityDictionary[key] as? NSUserActivity {
                    if let url = userActivity.webpageURL {
                        return url
                    }
                }
            }
        }
        
        return nil
    }
}
