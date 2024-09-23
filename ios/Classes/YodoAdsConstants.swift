struct YodoAdsConstants {
    static let MAIN_CHANNEL = "com.yodo1.mas/sdk";

    static let METHOD_NATIVE_INIT_SDK = "native_init_sdk";
    static let METHOD_NATIVE_IS_AD_LOADED = "native_is_ad_loaded";
    static let METHOD_NATIVE_SHOW_AD = "native_show_ad";

    static let METHOD_FLUTTER_INIT_EVENT = "flutter_init_event";
    static let METHOD_FLUTTER_AD_EVENT = "flutter_ad_event";
    static let DISMISS_BANNER = "dismiss_banner";

    static let HEIGHT_PARAMETER = "height";
    static let WIDTH_PARAMETER = "width";
    static let BANNER_LOAD_ERROR_METHOD = "banner_loaderror";
    static let BANNER_OPEN_ERROR_METHOD = "banner_OPENerror";
    static let BANNER_LOADED_METHOD = "banner_loaded";
    static let BANNER_OPEN_METHOD = "banner_open";
    static let BANNER_CLOSE_METHOD = "banner_close";

    static let BANNER_SIZE = "bannersize";
    static let BANNER_AD_CHANNEL = MAIN_CHANNEL + "/bannerAd";
    static let ERROR_CODE_PARAMETER = "errorCode";
    static let ERROR_MESSAGE_PARAMETER = "errorMessage";

    static let NATIVE_SIZE = "nativesize";
    static let NATIVE_COLOR = "nativecolor";
    static let NATIVE_AD_CHANNEL = MAIN_CHANNEL + "/nativeAd";
      static let NATIVE_LOAD_ERROR_METHOD = "native_loaderror";
        static let NATIVE_LOADED_METHOD = "native_loaded";
        static let NATIVE_CLOSE_METHOD = "native_close";
}
