import Flutter
import Yodo1MasCore

class NativeAdListener: NSObject,Yodo1MasNativeAdViewDelegate {
    let channel: FlutterMethodChannel

    init(channel: FlutterMethodChannel) {
        self.channel = channel
    }

    func onNativeAdLoaded(_ native: Yodo1MasNativeAdView)
    {

        channel.invokeMethod(YodoAdsConstants.NATIVE_LOADED_METHOD,arguments: [])
    }
    func onNativeAdFailed(toLoad native: Yodo1MasNativeAdView, withError error:
    Yodo1MasError)
    {
        let arguments = [YodoAdsConstants.ERROR_MESSAGE_PARAMETER:error.localizedDescription];
        channel.invokeMethod(YodoAdsConstants.NATIVE_LOAD_ERROR_METHOD, arguments: arguments);

    }

    func onNativeAdClosed(_ native: Yodo1MasNativeAdView)
    {

        channel.invokeMethod(YodoAdsConstants.NATIVE_CLOSE_METHOD,arguments: [])
    }


}
