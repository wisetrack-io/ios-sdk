# WiseTrack iOS SDK

The WiseTrack SDK is a powerful analytics tool for tracking user interactions, events, and application metrics in iOS applications. It provides a simple interface to initialize tracking, log events, manage SDK settings, and retrieve analytics data such as ID For Advertising (IDFA).

## Table of Contents
- [Requirements](#requirements)
- [Installation](#installation)
- [Initialization](#initialization)
- [Basic Usage](#basic-usage)
  - [Enabling/Disabling the SDK](#enablingdisabling-the-sdk)
  - [Requesting App Tracking Transparency (ATT) Authorization](#requesting-app-tracking-transparency-att-authorization)
  - [Starting/Stopping Tracking](#startingstopping-tracking)
  - [Setting Push Notification Tokens](#setting-push-notification-tokens)
  - [Logging Custom Events](#logging-custom-events)
  - [Setting Log Levels](#setting-log-levels)
- [Advanced Usage](#advanced-usage)
  - [Retrieving IDFA](#retrieving-idfa)
  - [Customizing SDK Behavior](#customizing-sdk-behavior)
- [Example Project](#example-project)
- [Troubleshooting](#troubleshooting)
- [License](#license)

## Requirements
- iOS 11.0 or later
- Xcode 14.0 or later
- Swift 5.0 or later
- CocoaPods for dependency management

## Installation
To integrate the WiseTrack SDK into your iOS project, follow these steps:

1. **Install CocoaPods** (if not already installed):
   ```bash
   gem install cocoapods
   ```

2. **Create or update your Podfile**:
   In your project directory, create or edit the `Podfile` to include the WiseTrack SDK. Add the following line to your target:

   ```ruby
   platform :ios, '11.0'

   target 'YourAppTarget' do
     use_frameworks!
     pod 'WiseTrack', '~> 1.0' # Replace with the latest version
   end
   ```

3. **Install the pod**:
   Run the following command in your project directory:
   ```bash
   pod install
   ```

4. **Open the workspace**:
   After installation, open the generated `.xcworkspace` file:
   ```bash
   open YourApp.xcworkspace
   ```

5. **Add App Tracking Transparency permission**:
   To support App Tracking Transparency (iOS 14+), add the following key to your `Info.plist`:
   ```xml
   <key>NSUserTrackingUsageDescription</key>
   <string>We use tracking to improve your app experience and personalize content.</string>
   ```

## Initialization
To start using the WiseTrack SDK, initialize it with a configuration object in your `AppDelegate` or `SceneDelegate`.

### Example: AppDelegate
```swift
import UIKit
import WiseTrack

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Initialize WiseTrack SDK
        WiseTrack.shared.initialize(with: WTInitialConfig(
            appToken: "your-app-token",
            storeName: .appstore,
            environment: .production, // Use .sandbox for testing
            trackingWattingTime: 5,
            startTrackerAutomatically: true
        ))
        return true
    }
}
```

### Example: SceneDelegate (iOS 13+)
```swift
import UIKit
import WiseTrack

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Initialize WiseTrack SDK
        WiseTrack.shared.initialize(with: WTInitialConfig(
            appToken: "your-app-token",
            storeName: .appstore,
            environment: .production,
            trackingWattingTime: 5,
            startTrackerAutomatically: true
        ))
    }
}
```

**Note**: Replace `"your-app-token"` with the token provided by the WiseTrack dashboard.

## Basic Usage
Below are common tasks you can perform with the WiseTrack SDK.

### Enabling/Disabling the SDK
You can enable or disable the SDK at runtime.

```swift
// Enable the SDK
WiseTrack.shared.setEnabled(enabled: true)

// Disable the SDK
WiseTrack.shared.setEnabled(enabled: false)
```

### Requesting App Tracking Transparency (ATT) Authorization
For iOS 14+, request user permission for tracking:

```swift
WiseTrack.shared.requestAppTrackingAuthorization { isAuthorized in
    print("Tracking Authorized: \(isAuthorized)")
}
```

### Starting/Stopping Tracking
Manually control tracking:

```swift
// Start tracking
WiseTrack.shared.startTracking()

// Stop tracking
WiseTrack.shared.stopTracking()
```

### Setting Push Notification Tokens
Set APNs or FCM tokens for push notifications:

```swift
// Set APNs token
WiseTrack.shared.setAPNSToken(token: "your-apns-token")

// Set FCM token
WiseTrack.shared.setFCMToken(token: "your-fcm-token")
```

### Logging Custom Events
Log custom or revenue events:

```swift
// Log a default event
WiseTrack.shared.logEvent(WTEvent.default(for: "Custom Event", params: [
    "key-str": .string("value"),
    "key-num": .num(1.1),
    "key-bool": .bool(true)
]))

// Log a revenue event
WiseTrack.shared.logEvent(WTEvent.revenue(for: "Purchase", currency: .USD, amount: 9.99, params: [
    "item": .string("Premium Subscription")
]))
```

### Setting Log Levels
Control the verbosity of SDK logs:

```swift
WiseTrack.shared.setLogLevel(.debug) // Options: .none, .error, .warning, .info, .debug
```


## Advanced Usage

### Retrieving IDFA
Get the Identifier for Advertisers (IDFA):

```swift
if let idfa = WiseTrack.shared.getIDFA() {
    print("IDFA: \(idfa)")
} else {
    print("IDFA not available")
}
```

### Customizing SDK Behavior
You can customize the SDK behavior through the `WTInitialConfig` parameters:
- `appToken`: Your unique app token.
- `storeName`: The app store (e.g., `.appstore`).
- `environment`: The environment (`.production`, `.sandbox`).
- `trackingWattingTime`: Delay before starting tracking (in seconds).
- `startTrackerAutomatically`: Whether to start tracking automatically.

## Example Project
An Example project demonstrating the WiseTrack SDK integration is available at [GitHub Repository URL](https://github.com/wisetrack-io/ios-sdk/tree/main/Example). Clone the repository and follow the setup instructions to see the SDK in action.

## Troubleshooting
- **SDK not initializing**: Ensure the `appToken` is correct and the network is reachable.
- **Tracking not working**: Verify that `setEnabled(true)` is called and ATT authorization is granted (iOS 14+).
- **Logs not appearing**: Set the log level to `.debug` for detailed output.

For further assistance, contact support at [support@wisetrack.io](mailto:support@wisetrack.io).

## License
The WiseTrack SDK is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.