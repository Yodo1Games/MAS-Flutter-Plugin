package com.yodo1.testmasfluttersdktwo.nativead;

import com.yodo1.testmasfluttersdktwo.YodoAdsConstants;


import android.app.Activity;
import android.content.Context;

import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class NativeAdFactory extends PlatformViewFactory {
    private final BinaryMessenger messenger;
    private Activity activity;
    public NativeAdView nativeAdView;

    public NativeAdFactory(BinaryMessenger messenger) {
        super(StandardMessageCodec.INSTANCE);
        this.messenger = messenger;
    }

    public void setActivity(Activity activity) {
        this.activity = activity;
    }

    @Override
    public PlatformView create(Context context, int viewId, Object args) {
        nativeAdView = new NativeAdView(activity, viewId, (Map<?, ?>) args, this.messenger);
        return nativeAdView;
    }

}
