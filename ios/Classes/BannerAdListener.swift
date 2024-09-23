// This class handles the banner listener
import Flutter
import Yodo1MasCore

class BannerAdListener: NSObject,Yodo1MasBannerAdViewDelegate {
    let channel: FlutterMethodChannel

    init(channel: FlutterMethodChannel) {
        self.channel = channel
    }


    func onBannerAdLoaded(_ banner: Yodo1MasBannerAdView)
    {
        
        channel.invokeMethod(YodoAdsConstants.BANNER_LOADED_METHOD,arguments: [])
    }
    func onBannerAdFailed(toLoad banner: Yodo1MasBannerAdView, withError error:
    Yodo1MasError)
    {
        let arguments = [YodoAdsConstants.ERROR_MESSAGE_PARAMETER:error.localizedDescription];
        channel.invokeMethod(YodoAdsConstants.BANNER_LOAD_ERROR_METHOD, arguments: arguments);

    }
    func onBannerAdOpened(_ banner: Yodo1MasBannerAdView)
    {
        
        channel.invokeMethod(YodoAdsConstants.BANNER_OPEN_METHOD,arguments: [])
    }
    func onBannerAdFailed(toOpen banner: Yodo1MasBannerAdView, withError error: Yodo1MasError)
     {
        let arguments = [YodoAdsConstants.ERROR_MESSAGE_PARAMETER:error.localizedDescription];
        channel.invokeMethod(YodoAdsConstants.BANNER_OPEN_ERROR_METHOD, arguments: arguments);
     }
    func onBannerAdClosed(_ banner: Yodo1MasBannerAdView)
    {
       
        channel.invokeMethod(YodoAdsConstants.BANNER_CLOSE_METHOD,arguments: [])
    }


}
