import Sentry

public class DummySentryLinker {
    public static func preload() {
        _ = SentrySDK.start
        _ = SentryClient.self
    }
}