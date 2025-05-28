var WiseTrack = (function () {
    function isAndroidBridgeAvailable() {
        return typeof WiseTrackBridge !== "undefined" && WiseTrackBridge !== null;
    }
    
    function isIOSBridgeAvailable() {
        return typeof window.webkit !== "undefined" &&
        typeof window.webkit.messageHandlers !== "undefined";
    }
    
    function callBridge(methodName, args) {
        if (isAndroidBridgeAvailable()) {
            if (typeof WiseTrackBridge[methodName] === "function") {
                return WiseTrackBridge[methodName].apply(WiseTrackBridge, args);
            } else {
                console.warn(`[WiseTrack]: Method ${methodName} not found on Android bridge`);
            }
        } else if (isIOSBridgeAvailable()) {
            const handler = window.webkit.messageHandlers[methodName];
            if (handler && typeof handler.postMessage === "function") {
                handler.postMessage(args[0] ?? null);
            } else {
                console.warn(`[WiseTrack]: iOS handler ${methodName} not found`);
            }
        } else {
            console.error("[WiseTrack]: No bridge available");
        }
    }
    
    return {
        initialize(config) {
            if (!(config instanceof WTInitConfig)) {
                console.error('[WiseTrack]: Config must be an instance of WTInitConfig');
                return;
            }
            try {
                const configString = JSON.stringify(config.toJSON());
                callBridge("initialize", [configString]);
            } catch (e) {
                console.error('[WiseTrack]: initialize failed:', e.message);
            }
        },
        
        clearDataAndStop() {
            callBridge("clearDataAndStop", []);
        },
        
        setLogLevel(level) {
            if (!Object.values(WTLogLevel).includes(level)) {
                console.warn('[WiseTrack]: Invalid log level:', level);
                return;
            }
            callBridge("setLogLevel", [level]);
        },
        
        setEnabled(enabled) {
            if (typeof enabled !== 'boolean') {
                console.warn('[WiseTrack]: Enabled must be a boolean');
                return;
            }
            callBridge("setEnabled", [enabled.toString()]);
        },
        
        requestForATT() {
            return new Promise((resolve, reject) => {
                const callbackId = `cb_${Date.now()}_${Math.random().toString(36).substr(2, 5)}`;
                this._callbacks[callbackId] = resolve;
                
                callBridge("requestForATT", [{ callbackId: callbackId }]);
            });
        },
        
        getIDFA() {
            return new Promise((resolve, reject) => {
                const callbackId = `cb_${Date.now()}_${Math.random().toString(36).substr(2, 5)}`;
                this._callbacks[callbackId] = resolve;
                
                callBridge("getIDFA", [{ callbackId: callbackId }]);
            });
        },
        
        getADID() {
            if(isAndroidBridgeAvailable()){
                return callBridge("getADID", []);
            }
        },
        
        getReferrer() {
            if(isAndroidBridgeAvailable()){
                return callBridge("getReferrer", []);
            }
        },
        
        startTracking() {
            callBridge("startTracking", [null]);
        },
        
        stopTracking() {
            callBridge("stopTracking", [null]);
        },
        
        destroy() {
            callBridge("destroy", [null]);
        },
        
        setPackagesInfo() {
            callBridge("setPackagesInfo", [null]);
        },
        
        setFCMToken(token) {
            if (typeof token !== 'string') {
                console.warn('[WiseTrack]: FCM token must be a string');
                return;
            }
            callBridge("setFCMToken", [token]);
        },
        
        setAPNSToken(token) {
            if (typeof token !== 'string') {
                console.warn('[WiseTrack]: APNS token must be a string');
                return;
            }
            callBridge("setAPNSToken", [token]);
        },
        
        logEvent(event) {
            if (!(event instanceof WTEvent)) {
                console.warn('[WiseTrack]: Event must be an instance of WTEvent');
                return;
            }
            try {
                const eventString = JSON.stringify(event.toJSON());
                callBridge("logEvent", [eventString]);
            } catch (e) {
                console.error('[WiseTrack]: logEvent failed:', e.message);
            }
        },
        
        isEnabled() {
            return new Promise((resolve, reject) => {
                if(isAndroidBridgeAvailable()){
                    resolve(callBridge("isEnabled", []));
                    return;
                }
                const callbackId = `cb_${Date.now()}_${Math.random().toString(36).substr(2, 5)}`;
                this._callbacks[callbackId] = resolve;
                
                callBridge("isEnabled", [{ callbackId: callbackId }]);
            });
        },
        
        _callbacks: {},
        
        onNativeResponse(response) {
            if (!response || !response.callbackId) return;
            const cb = this._callbacks[response.callbackId];
            if (cb) {
                cb(response.data);
                delete this._callbacks[response.callbackId];
            }
        }
    };
})();
