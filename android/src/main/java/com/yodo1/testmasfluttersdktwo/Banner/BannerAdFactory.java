package com.yodo1.testmasfluttersdktwo.banner;

import com.yodo1.testmasfluttersdktwo.YodoAdsConstants;


import android.app.Activity;
import android.content.Context;

import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class BannerAdFactory extends PlatformViewFactory {
    private final BinaryMessenger messenger;
    public com.yodo1.testmasfluttersdktwo.banner.BannerAdView bannerAdView;
    private Activity activity;

    public BannerAdFactory(BinaryMessenger messenger) {
        super(StandardMessageCodec.INSTANCE);
        this.messenger = messenger;
    }

    public void setActivity(Activity activity) {
        this.activity = activity;
    }

    @Override
    public PlatformView create(Context context, int viewId, Object args) {
        bannerAdView = new com.yodo1.testmasfluttersdktwo.banner.BannerAdView(activity, viewId, (Map<?, ?>) args, this.messenger);
        return bannerAdView;
    }

}
