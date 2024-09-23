// This class implements the banner Ad view
import Flutter
import UIKit
import Yodo1MasCore

class BannerAdView: NSObject, FlutterPlatformView {
    
    private let uiView = BannerAdContentView()
    private let listener : BannerAdListener

    init(frame: CGRect, id: Int64, arguments: Any?, messenger: FlutterBinaryMessenger) {
       
        
        let channel = FlutterMethodChannel(name: YodoAdsConstants.BANNER_AD_CHANNEL + "_" + id.description,  binaryMessenger:  messenger)
        let args = arguments as? [String: Any] ?? [:]
        let size = args[YodoAdsConstants.BANNER_SIZE] as? String ?? ""
        
        listener = BannerAdListener(channel: channel)
        super.init()
        uiView.bannerAdView.adDelegate = listener
        uiView.bannerAdView.setAdSize(self.getBannerSize(BannerSize: size))
        uiView.bannerAdView.loadAd()
        uiView.frame = frame
    }

    func view() -> UIView {
        uiView
    }

    func getBannerSize(BannerSize : String) -> Yodo1MasBannerAdSize {
        switch BannerSize
        {
            case "Banner":
                return .banner
            case "AdaptiveBanner":
                return .adaptiveBanner
            case "LargeBanner":
                return .largeBanner
            case "SmartBanner":
                return .smartBanner
            case "IABMediumRectangle":
                return .iabMediumRectangle
            default:
                return .banner
        }
    }
}

class BannerAdContentView: UIView {
    let bannerAdView = Yodo1MasBannerAdView()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubviews()
    }
    
    private func setSubviews() {
        self.addSubview(bannerAdView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bannerAdView.center = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
    }
}
