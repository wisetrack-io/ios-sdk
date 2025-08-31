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
        //initial
        let config = WTInitialConfig(
            appToken: "<App-Token>",
            storeName: .other,
            environment: .sandbox,
            logLevel: .debug,
            trackingWaitingTime: 5,
            startTrackerAutomatically: true,
            customDeviceId: "custom-device-id",
            appSecret: "app-secret",
            secretId: "secret-id"
        )
        WiseTrack.shared.initialize(with: config)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = ViewController()
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // request to ATT for IDFA (NOTE: add Info.plist setting [NSUserTrackingUsageDescription])
        WiseTrack.shared.requestAppTrackingAuthorization { isAuthorized in
//             call startTracking() if set startTrackerAutomatically to false
//            WiseTrack.shared.startTracking()
        }
    }
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        WiseTrack.shared.setAPNSToken(tokenData: deviceToken)
    }
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

        if WiseTrack.shared.isWiseTrackNotificationPayload(userInfo: userInfo) {
            // WiseTrack handle this notification
            completionHandler(.newData)
            return
        }
        // Handle your app's custom notifications here if needed
    }
}