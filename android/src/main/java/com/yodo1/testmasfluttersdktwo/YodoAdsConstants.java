package com.yodo1.testmasfluttersdktwo;

public interface YodoAdsConstants {
    String MAIN_CHANNEL = "com.yodo1.mas/sdk";

    String METHOD_NATIVE_INIT_SDK = "native_init_sdk";
    String METHOD_NATIVE_IS_AD_LOADED = "native_is_ad_loaded";
    String METHOD_NATIVE_SHOW_AD = "native_show_ad";
    String METHOD_NATIVE_LOAD_AD = "native_load_ad";

    String METHOD_FLUTTER_INIT_EVENT = "flutter_init_event";
    String METHOD_FLUTTER_AD_EVENT = "flutter_ad_event";
    String DISMISS_BANNER = "dismiss_banner";
    String DISMISS_BANNER2 = "dismiss_banner2";
    String DISMISS_NATIVE2 = "dismiss_native";
    //String REPORT_AD = "reportad";

    String HEIGHT_PARAMETER = "height";
    String WIDTH_PARAMETER = "width";

    String BANNER_LOAD_ERROR_METHOD = "banner_loaderror";
    String BANNER_OPEN_ERROR_METHOD = "banner_openerror";
    String BANNER_LOADED_METHOD = "banner_loaded";
    String BANNER_OPEN_METHOD = "banner_open";
    String BANNER_CLOSE_METHOD = "banner_close";

    String BANNER_SIZE = "bannersize";
    String BANNER_AD_CHANNEL = MAIN_CHANNEL + "/bannerAd";
    String ERROR_CODE_PARAMETER = "errorCode";
    String ERROR_MESSAGE_PARAMETER = "errorMessage";
    String AD_VIEW = "adView";

    String NATIVE_SIZE = "nativesize";
    String NATIVE_COLOR = "nativecolor";
    String NATIVE_AD_CHANNEL = MAIN_CHANNEL + "/nativeAd";

    String NATIVE_LOAD_ERROR_METHOD = "native_loaderror";
    String NATIVE_OPEN_ERROR_METHOD = "native_openerror";
    String NATIVE_LOADED_METHOD = "native_loaded";
    String NATIVE_OPEN_METHOD = "native_open";
    String NATIVE_CLOSE_METHOD = "native_close";
}
