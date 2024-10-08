import 'dart:io';
import 'dart:developer';
import 'dart:isolate';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class Yodo1MAS {
  static const _CHANNEL = "com.yodo1.mas/sdk";
  static const _METHOD_NATIVE_INIT_SDK = "native_init_sdk";
  static const _METHOD_NATIVE_IS_AD_LOADED = "native_is_ad_loaded";
  static const _METHOD_NATIVE_LOAD_AD = "native_load_ad";
  static const _METHOD_NATIVE_SHOW_AD = "native_show_ad";
  static const _METHOD_FLUTTER_INIT_EVENT = "flutter_init_event";
  static const _METHOD_FLUTTER_AD_EVENT = "flutter_ad_event";
  static const _METHOD_DISMISS_BANNER = "dismiss_banner";
  static const _METHOD_DISMISS_BANNER2 = "dismiss_banner2";
  static const _METHOD_DISMISS_NATIVE = "dismiss_native";
  static const _REPORT_AD = "reportad";


  static const AD_TYPE_REWARD = 1;
  static const AD_TYPE_INTERSTITIAL = 2;
  static const AD_TYPE_BANNER = 3;
  static const AD_TYPE_APP_OPEN = 4;

  static const AD_EVENT_OPENED = 1001;
  static const AD_EVENT_CLOSED = 1002;
  static const AD_EVENT_ERROR = 1003;
  static const AD_EVENT_EARNED = 2001;

  static const _channel = const MethodChannel(_CHANNEL);

  Yodo1MAS._privateConstructor();
  static final Yodo1MAS instance = Yodo1MAS._privateConstructor();

  Function(bool successful)? _initCallback;
  Function(int event, String message)? _rewardCallback;
  Function(int event, String message)? _interstitialCallback;
  Function(int event, String message)? _bannerCallback;

  void initSdk(String appKey, bool privacy, bool ccpa, bool coppa, bool gdpr, Function(bool successful)? callback) {
    _initCallback = callback;

    _channel.setMethodCallHandler((call) {

      switch(call.method) {

        case _METHOD_FLUTTER_INIT_EVENT: {

          bool successful = call.arguments["successful"];
          if (_initCallback != null) {
            _initCallback!(successful);
          }
          return Future<bool>.value(true);
        }
        case _METHOD_FLUTTER_AD_EVENT: {
          int type,code;
          String message;
          if (defaultTargetPlatform == TargetPlatform.android)
          {
            Map<String, dynamic> map = json.decode(call.arguments);
             type = map["type"];
             code = map["code"];
             message = map["message"];
          }
          else
            {
               type = call.arguments["type"];
               code = call.arguments["code"];
               message = call.arguments["message"];
            }




          log("\n $type" +  " yodo1 ===================@@");
          debugPrint("\n $type" + " yodo1 ===================@@");
          print("\n $type" +  " yodo1 ===================@@");
          switch (type) {
            case AD_TYPE_REWARD:

              if (_rewardCallback != null) {
                _rewardCallback!(code, message);
              }
              break;
            case AD_TYPE_INTERSTITIAL:
              if (_interstitialCallback != null) {
                _interstitialCallback!(code, message);
              }
              break;
            case AD_TYPE_BANNER:
              if (_bannerCallback != null) {
                _bannerCallback!(code, message);
              }
              break;
          }

          return Future<bool>.value(true);
        }
      }
      return Future<bool>.value(true);
    });
    _channel.invokeMethod(_METHOD_NATIVE_INIT_SDK, {"app_key": appKey, "privacy" : privacy, "ccpa": ccpa, "gdpr": gdpr, "coppa": coppa});
  }

  void setRewardListener(Function(int event, String message)? callback) {
    _rewardCallback = callback;
  }

  void setInterstitialListener(Function(int event, String message)? callback) {
    _interstitialCallback = callback;
  }

  void setBannerListener(Function(int event, String message)? callback) {
    _bannerCallback = callback;
  }

  void loadInterstitialAd() {
    _channel.invokeMethod(_METHOD_NATIVE_LOAD_AD, {"ad_type": "Interstitial"});
  }

  void loadRewardAd() {
    _channel.invokeMethod(_METHOD_NATIVE_LOAD_AD, {"ad_type": "Reward"});
  }

  void loadAppOpenAd() {
    _channel.invokeMethod(_METHOD_NATIVE_LOAD_AD, {"ad_type": "AppOpen"});
  }
  Future<bool?> isRewardAdLoaded() {
    return _channel.invokeMethod<bool>(_METHOD_NATIVE_IS_AD_LOADED, {"ad_type" : "Reward"});
  }

  void showRewardAd() {
    _channel.invokeMethod(_METHOD_NATIVE_SHOW_AD, {"ad_type" : "Reward"});
  }

  Future<bool?> isInterstitialAdLoaded() {
    return _channel.invokeMethod<bool>(_METHOD_NATIVE_IS_AD_LOADED, {"ad_type" : "Interstitial"});
  }

  void showInterstitialAd() {
    _channel.invokeMethod(_METHOD_NATIVE_SHOW_AD, {"ad_type" : "Interstitial"});
  }

  Future<bool?> isBannerAdLoaded() {
    return _channel.invokeMethod<bool>(_METHOD_NATIVE_IS_AD_LOADED, {"ad_type" : "Banner"});
  }

  void showBannerAd() {
    _channel.invokeMethod(_METHOD_NATIVE_SHOW_AD, {"ad_type" : "Banner"});
  }

  void dismissBannerAd() {
    _channel.invokeMethod(_METHOD_DISMISS_BANNER);
  }
  void dismissBannerAd2() {
    _channel.invokeMethod(_METHOD_DISMISS_BANNER2);
  }
  void dismissNativeAd() {
    _channel.invokeMethod(_METHOD_DISMISS_NATIVE);
  }

  void showReportAdDialog() {
    _channel.invokeMethod(_REPORT_AD);
  }
}