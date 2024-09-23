package com.yodo1.testmasfluttersdktwo.nativead;

import java.util.HashMap;
import java.util.Map;
import androidx.annotation.NonNull;
import io.flutter.plugin.common.MethodChannel;
import com.yodo1.mas.Yodo1Mas;
import com.yodo1.mas.error.Yodo1MasError;
import com.yodo1.mas.event.Yodo1MasAdEvent;
import com.yodo1.mas.helper.model.Yodo1MasAdBuildConfig;
import com.yodo1.mas.nativeads.Yodo1MasNativeAdView;
import com.yodo1.mas.nativeads.Yodo1MasNativeAdListener;
import com.yodo1.testmasfluttersdktwo.YodoAdsConstants;

public class NativeAdListener implements Yodo1MasNativeAdListener {

    private final MethodChannel channel;
 private int adload = 0, adopen = 0, adfail = 0, adclose = 0;


    public NativeAdListener(MethodChannel channel) {
        this.channel = channel;
    }

    @Override
    public void onNativeAdLoaded(Yodo1MasNativeAdView nativeAdView) {
        if(adopen ==0) {
        Map<String, String> arguments = new HashMap<>();
        channel.invokeMethod(YodoAdsConstants.NATIVE_LOADED_METHOD,arguments);
        adopen = 1;
        }
    }

    @Override
    public void onNativeAdFailedToLoad(Yodo1MasNativeAdView nativeAdView, @NonNull Yodo1MasError error) {
        if(adfail == 0)
        {
        Map<String, String> arguments = new HashMap<>();
        arguments.put(YodoAdsConstants.ERROR_MESSAGE_PARAMETER, error.getMessage());
        if(nativeAdView != null) {
                    //nativeAdView.destroy();
                }
        channel.invokeMethod(YodoAdsConstants.NATIVE_LOAD_ERROR_METHOD, arguments);
        adfail = 1;
        }
    }


    public void onNativeAdClosed(Yodo1MasNativeAdView nativeAdView)
    {
        if(adclose == 0)
        {
        Map<String, String> arguments = new HashMap<>();
        channel.invokeMethod(YodoAdsConstants.NATIVE_CLOSE_METHOD,arguments);
        adclose = 1;
        }
    }



}