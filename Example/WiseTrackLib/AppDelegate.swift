//
//  AppDelegate.swift
//  WiseTrackLib
//
//  Created by 29954885 on 01/11/2025.
//  Copyright (c) 2025 29954885. All rights reserved.
//

import UIKit
import WiseTrackLib
import Sentry

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {    
        // add WT.StoreName key to Info.plist if you want seprate your publish

        // set log level
        WiseTrack.shared.setLogLevel(.debug)
        
        //initial
        let config = WTInitialConfig(
            appToken: "5oj3KkQpPDP3",
            storeName: .appstore,
            enviroment: .sandbox,
            logLevel: .debug,
            trackingWattingTime: 5,
            startTrackerAutomatically: true,
            customDeviceId: "custom-device-id",
            appSecret: "app-secret",
            secretId: "secret-id"
        )
        WiseTrack.shared.initialize(with: config)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = LoginViewController()
//        window!.makeKeyAndVisible()
        
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