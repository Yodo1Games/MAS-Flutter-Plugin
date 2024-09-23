import Flutter
import UIKit
import Yodo1MasCore


class NativeAdView: NSObject, FlutterPlatformView {
    //private let nativeView : UADSNativeView
    
    private let uiView = NativeAdContentView()
    let listener : NativeAdListener
    let nativeAdView = Yodo1MasNativeAdView()

    init(frame: CGRect, id: Int64, arguments: Any?, messenger: FlutterBinaryMessenger) {
        
        let channel =  FlutterMethodChannel(
            name: YodoAdsConstants.NATIVE_AD_CHANNEL + "_" + id.description,  binaryMessenger:  messenger)
        let args = arguments as! [String: Any]? ?? [:]
        let size = args[YodoAdsConstants.NATIVE_SIZE] as? String ?? ""
        let backgroundColor = args[YodoAdsConstants.NATIVE_COLOR] as? String ?? ""
        
        
        listener = NativeAdListener(channel: channel)
        super.init()
        //let nativeAdView = Yodo1MasNativeAdView()
        if(size == "NativeLarge")
        {
            uiView.nativeAdView.frame = CGRect(x: 0, y: 0, width: 400, height: 300)
        }
        else if( size == "NativeSmall")
        {
            uiView.nativeAdView.frame = CGRect(x: 0, y: 0, width: 300, height: 100)
        }
        
        if(!backgroundColor.isEmpty)
        {
            guard let color = Color(rawValue: backgroundColor.lowercased()) else { "handle invalid color error"; return }
             let colorSelected = color.create
            uiView.nativeAdView.adBackgroundColor = colorSelected

        }
        
        uiView.nativeAdView.adDelegate = listener
        //uiView.addSubview(nativeAdView)
        //uiView.layoutIfNeeded()
        
        uiView.nativeAdView.loadAd()
        //uiView.frame = frame

    }

    func view() -> UIView {
        uiView
    }
    
    class NativeAdContentView: UIView {
        let nativeAdView = Yodo1MasNativeAdView()
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setSubviews()
        }
        
        override init(frame: CGRect) {
            
            super.init(frame: frame)
            setSubviews()
        }
        
        private func setSubviews() {
            self.addSubview(nativeAdView)
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            nativeAdView.center = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
        }
    }
    
    enum Color: String {
       case red
       case blue
       case green
       case black
       case white
       case brown
       case yellow
       case orange
       case gray
       case lightgrey
       case pink
       case purple
       case cyan
       case magenta

        var create: UIColor {
           switch self {
              case .red:
                return UIColor.red
            case .blue:
                return UIColor.blue
            case .green:
                return UIColor.green
           case.white:
               return UIColor.white
           case.black:
               return UIColor.black
           case .brown:
               return UIColor.brown
           case.yellow:
               return UIColor.yellow
           case .orange:
               return UIColor.orange
           case .gray:
               return UIColor.gray
           case .lightgrey:
               return UIColor.lightGray
           case .pink:
               return UIColor.systemPink
           case .purple:
               return UIColor.purple
           case .cyan:
               return UIColor.cyan
           case .magenta:
               return UIColor.magenta
           }
        }
      }

    

}

