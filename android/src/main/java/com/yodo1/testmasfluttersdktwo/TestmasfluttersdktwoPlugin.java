package com.yodo1.testmasfluttersdktwo;
import static com.yodo1.testmasfluttersdktwo.YodoAdsConstants.DISMISS_BANNER2;
import static com.yodo1.testmasfluttersdktwo.YodoAdsConstants.DISMISS_NATIVE2;

import android.app.Activity;
import android.content.Context;
import android.provider.Settings;
import android.view.View;

import androidx.annotation.NonNull;



import java.util.HashMap;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import com.google.gson.JsonObject;
import com.yodo1.mas.Yodo1Mas;
import com.yodo1.mas.error.Yodo1MasError;
import com.yodo1.mas.event.Yodo1MasAdEvent;
import com.yodo1.mas.helper.model.Yodo1MasAdBuildConfig;
import com.yodo1.mas.banner.Yodo1MasBannerAdView;
import com.yodo1.mas.banner.Yodo1MasBannerAdSize;
import com.yodo1.mas.interstitial.Yodo1MasInterstitialAd;
import com.yodo1.mas.interstitial.Yodo1MasInterstitialAdListener;
import com.yodo1.mas.reward.Yodo1MasRewardAd;
import com.yodo1.mas.reward.Yodo1MasRewardAdListener;
import com.yodo1.testmasfluttersdktwo.banner.BannerAdFactory;
import com.yodo1.testmasfluttersdktwo.nativead.NativeAdFactory;

public class TestmasfluttersdktwoPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
    private MethodChannel channel;
    private Context context;
    private Activity activity;
    private Map<String, MethodChannel> placementChannels;
    private BinaryMessenger binaryMessenger;
    private BannerAdFactory bannerAdFactory;
    private NativeAdFactory nativeAdFactory;
    public static final String METHOD_NATIVE_INIT_SDK = "native_init_sdk";
    public static final String METHOD_NATIVE_IS_AD_LOADED = "native_is_ad_loaded";
    public  static final String METHOD_NATIVE_SHOW_AD = "native_show_ad";

    public static final String METHOD_FLUTTER_INIT_EVENT = "flutter_init_event";
    public static final String METHOD_FLUTTER_AD_EVENT = "flutter_ad_event";
    public static final String DISMISS_BANNER = "dismiss_banner";
    public static final String REPORT_AD = "reportad";


    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), YodoAdsConstants.MAIN_CHANNEL);
        channel.setMethodCallHandler(this);
        context = flutterPluginBinding.getApplicationContext();
        binaryMessenger = flutterPluginBinding.getBinaryMessenger();
        //placementChannels = new HashMap<>();
        bannerAdFactory = new BannerAdFactory(binaryMessenger);
        flutterPluginBinding.getPlatformViewRegistry()
                .registerViewFactory(YodoAdsConstants.BANNER_AD_CHANNEL, bannerAdFactory);
        nativeAdFactory = new NativeAdFactory(binaryMessenger);
        flutterPluginBinding.getPlatformViewRegistry()
                .registerViewFactory(YodoAdsConstants.NATIVE_AD_CHANNEL, nativeAdFactory);
        initializeAdsCallback();

    }



    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        switch (call.method) {
            case METHOD_NATIVE_INIT_SDK: {
                String appKey = call.argument("app_key");
                boolean privacy = call.argument("privacy");
                if (appKey != null) {
                    initSdk(appKey,privacy);
                }
                result.success(null);
                break;
            }
            case METHOD_NATIVE_IS_AD_LOADED:{
                boolean isAdLoaded = false;
                String type = call.argument("ad_type");
                if (type != null) {
                    switch (type) {
                        case "Reward": {
                            isAdLoaded = Yodo1MasRewardAd.getInstance().isLoaded();
                            break;
                        }
                        case "Interstitial": {
                            isAdLoaded = Yodo1MasInterstitialAd.getInstance().isLoaded();
                            break;
                        }
                        case "Banner": {
                            isAdLoaded = Yodo1Mas.getInstance().isBannerAdLoaded();
                            break;
                        }
                    }
                }
                result.success(isAdLoaded);
                break;
            }
            case METHOD_NATIVE_SHOW_AD: {
                String type = call.argument("ad_type");
                if (type != null) {
                    switch (type) {
                        case "Reward": {
                            Yodo1MasRewardAd.getInstance().showAd(TestmasfluttersdktwoPlugin.this.activity);
                            break;
                        }
                        case "Interstitial": {
                            Yodo1MasInterstitialAd.getInstance().showAd(TestmasfluttersdktwoPlugin.this.activity);
                            break;
                        }
                        case "Banner": {
                            //Yodo1Mas.getInstance().showBannerAd(TestmasfluttersdktwoPlugin.this.activity);
                            Yodo1MasBannerAdView bannerAdView = new Yodo1MasBannerAdView(TestmasfluttersdktwoPlugin.this.activity);
                            bannerAdView.setAdSize(Yodo1MasBannerAdSize.Banner);
                            bannerAdView.loadAd();
                            break;
                        }
                    }
                }
                result.success(null);
                break;
            }
            case DISMISS_BANNER: {
                Yodo1Mas.getInstance().dismissBannerAd();
                result.success(null);
                break;

            }
            case DISMISS_BANNER2: {
                if(bannerAdFactory.bannerAdView != null) {
                    bannerAdFactory.bannerAdView.bannerAdView.setVisibility(View.GONE);
                    bannerAdFactory.bannerAdView.bannerAdView.destroy();
                }
                result.success(null);
                break;
            }
            case DISMISS_NATIVE2: {
                if(nativeAdFactory.nativeAdView != null) {
                    nativeAdFactory.nativeAdView.nativeAdView.setVisibility(View.GONE);
                    nativeAdFactory.nativeAdView.nativeAdView.destroy();
                }
                result.success(null);
                break;
            }
            case REPORT_AD: {
                Yodo1Mas.getInstance().showPopupToReportAd(TestmasfluttersdktwoPlugin.this.activity);
                result.success(null);
                break;
            }
        }

    }

    private void initSdk(@NonNull String appKey,boolean privayDialog) {
        if(privayDialog) {
            Yodo1MasAdBuildConfig config = new Yodo1MasAdBuildConfig.Builder().enableUserPrivacyDialog(true).build();
            Yodo1Mas.getInstance().setAdBuildConfig(config);
        }
        else
        {
            Yodo1MasAdBuildConfig config = new Yodo1MasAdBuildConfig.Builder().enableUserPrivacyDialog(false).build();
            Yodo1Mas.getInstance().setAdBuildConfig(config);
            Yodo1Mas.getInstance().setCOPPA(false);
            Yodo1Mas.getInstance().setCCPA(false);
            Yodo1Mas.getInstance().setGDPR(true);
        }
        Yodo1Mas.getInstance().init(activity, appKey, new Yodo1Mas.InitListener() {
            @Override
            public void onMasInitSuccessful() {
                if (channel != null) {
                    Yodo1MasInterstitialAd.getInstance().loadAd(activity);
                    Yodo1MasRewardAd.getInstance().loadAd(activity);
                    JsonObject json = new JsonObject();
                    json.addProperty("successful", true);
                    //Log.d(FlutterYodo1Mas.CHANNEL, "调用Flutter方法 - " + METHOD_FLUTTER_INIT_EVENT);
                    Map<String, String> args = new HashMap<>();
                    args.put("successful", "true");
                    //Yodo1Mas.getInstance().showPopupToReportAd(TestmasfluttersdktwoPlugin.this.activity);
                    channel.invokeMethod(METHOD_FLUTTER_INIT_EVENT, args);
                }
            }

            @Override
            public void onMasInitFailed(@NonNull Yodo1MasError error) {
                if (channel != null) {
                    JsonObject json = new JsonObject();
                    json.addProperty("successful", false);
                    json.addProperty("error", error.getJsonObject().toString());
                    channel.invokeMethod(METHOD_FLUTTER_INIT_EVENT, json.toString());
                }
            }
        });
    }


    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        activity = binding.getActivity();
        bannerAdFactory.setActivity(activity);
        nativeAdFactory.setActivity(activity);
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {

    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {

    }

    @Override
    public void onDetachedFromActivity() {

    }

    void initializeAdsCallback() {


        Yodo1Mas.getInstance().setRewardListener(new Yodo1Mas.RewardListener() {
            @Override
            public void onAdOpened(@NonNull Yodo1MasAdEvent event) {
                if (channel != null) {
                    channel.invokeMethod(METHOD_FLUTTER_AD_EVENT, event.getJSONObject().toString());
                }
            }

            @Override
            public void onAdError(@NonNull Yodo1MasAdEvent event, @NonNull Yodo1MasError error) {
                if (channel != null) {
                    channel.invokeMethod(METHOD_FLUTTER_AD_EVENT, event.getJSONObject().toString());
                }
            }

            @Override
            public void onAdClosed(@NonNull Yodo1MasAdEvent event) {
                if (channel != null) {
                    channel.invokeMethod(METHOD_FLUTTER_AD_EVENT, event.getJSONObject().toString());
                }
            }

            @Override
            public void onAdvertRewardEarned(@NonNull Yodo1MasAdEvent event) {
                if (channel != null) {
                    channel.invokeMethod(METHOD_FLUTTER_AD_EVENT, event.getJSONObject().toString());
                }
            }
        });

        /*
        Yodo1MasRewardAd.getInstance().setAdListener(new Yodo1MasRewardAdListener() {

            @Override
            public void onRewardAdLoaded(Yodo1MasRewardAd ad) {

            }

            @Override
            public void onRewardAdFailedToLoad(Yodo1MasRewardAd ad, @NonNull Yodo1MasError error) {
                if (channel != null) {
                    ad.loadAd(activity);
                    channel.invokeMethod(METHOD_FLUTTER_AD_EVENT, ad.toString());
                }
            }

            @Override
            public void onRewardAdOpened(Yodo1MasRewardAd ad) {
                if (channel != null) {
                    channel.invokeMethod(METHOD_FLUTTER_AD_EVENT, ad.toString());
                }
            }

            @Override
            public void onRewardAdFailedToOpen(Yodo1MasRewardAd ad, @NonNull Yodo1MasError error) {
                ad.loadAd(activity);
            }

            @Override
            public void onRewardAdClosed(Yodo1MasRewardAd ad) {
                if (channel != null) {
                    channel.invokeMethod(METHOD_FLUTTER_AD_EVENT, ad.toString());
                }
                ad.loadAd(activity);
            }

            @Override
            public void onRewardAdEarned(Yodo1MasRewardAd ad) {

            }
        });

        Yodo1MasInterstitialAd.getInstance().setAdListener(new Yodo1MasInterstitialAdListener() {

            @Override
            public void onInterstitialAdLoaded(Yodo1MasInterstitialAd ad) {


            }

            @Override
            public void onInterstitialAdFailedToLoad(Yodo1MasInterstitialAd ad, @NonNull Yodo1MasError error) {
                if (channel != null) {
                    ad.loadAd(activity);
                    channel.invokeMethod(METHOD_FLUTTER_AD_EVENT, ad.toString());
                }

            }

            @Override
            public void onInterstitialAdOpened(Yodo1MasInterstitialAd ad) {
                if (channel != null) {
                    channel.invokeMethod(METHOD_FLUTTER_AD_EVENT, ad.toString());
                }
            }

            @Override
            public void onInterstitialAdFailedToOpen(Yodo1MasInterstitialAd ad, @NonNull Yodo1MasError error) {
                ad.loadAd(activity);
            }

            @Override
            public void onInterstitialAdClosed(Yodo1MasInterstitialAd ad) {
                if (channel != null) {
                    channel.invokeMethod(METHOD_FLUTTER_AD_EVENT, ad.toString());
                }
                ad.loadAd(activity);
            }
        });
       */
        Yodo1Mas.getInstance().setInterstitialListener(new Yodo1Mas.InterstitialListener() {
            @Override
            public void onAdOpened(@NonNull Yodo1MasAdEvent event) {
                if (channel != null) {
                    channel.invokeMethod(METHOD_FLUTTER_AD_EVENT, event.getJSONObject().toString());
                }
            }

            @Override
            public void onAdError(@NonNull Yodo1MasAdEvent event, @NonNull Yodo1MasError error) {
                if (channel != null) {
                    channel.invokeMethod(METHOD_FLUTTER_AD_EVENT, event.getJSONObject().toString());
                }
            }

            @Override
            public void onAdClosed(@NonNull Yodo1MasAdEvent event) {
                if (channel != null) {
                    channel.invokeMethod(METHOD_FLUTTER_AD_EVENT, event.getJSONObject().toString());
                }
            }
        });

        Yodo1Mas.getInstance().setBannerListener(new Yodo1Mas.BannerListener() {
            @Override
            public void onAdOpened(@NonNull Yodo1MasAdEvent event) {
                if (channel != null) {
                    channel.invokeMethod(METHOD_FLUTTER_AD_EVENT, event.getJSONObject().toString());
                }
            }

            @Override
            public void onAdError(@NonNull Yodo1MasAdEvent event, @NonNull Yodo1MasError error) {
                if (channel != null) {
                    channel.invokeMethod(METHOD_FLUTTER_AD_EVENT, event.getJSONObject().toString());
                }
            }

            @Override
            public void onAdClosed(@NonNull Yodo1MasAdEvent event) {
                if (channel != null) {
                    channel.invokeMethod(METHOD_FLUTTER_AD_EVENT, event.getJSONObject().toString());
                }
            }
        });
    }

}
