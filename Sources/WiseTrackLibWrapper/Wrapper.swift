import Sentry

public class DummySentryLinker {
    public static func preload() {
        let isEnabled = SentrySDK.isEnabled
        print("sentry enabled = \(isEnabled)")
        
        _ = SentryClient.self
    }
}