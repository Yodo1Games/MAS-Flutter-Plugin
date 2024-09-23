package com.yodo1.testmasfluttersdktwo.banner;

import android.util.Log;

import java.util.HashMap;
import java.util.Map;
import androidx.annotation.NonNull;
import io.flutter.plugin.common.MethodChannel;
import com.yodo1.mas.Yodo1Mas;
import com.yodo1.mas.error.Yodo1MasError;
import com.yodo1.mas.event.Yodo1MasAdEvent;
import com.yodo1.mas.helper.model.Yodo1MasAdBuildConfig;
import com.yodo1.mas.banner.Yodo1MasBannerAdView;
import com.yodo1.mas.banner.Yodo1MasBannerAdSize;
import com.yodo1.mas.banner.Yodo1MasBannerAdListener;
import com.yodo1.testmasfluttersdktwo.YodoAdsConstants;

public class BannerAdListener implements  Yodo1MasBannerAdListener {

    private final MethodChannel channel;
    private int adload = 0, adopen = 0, adfail = 0, adclose = 0;
    public BannerAdListener(MethodChannel channel) {
        this.channel = channel;
    }


    @Override
    public void onBannerAdLoaded(Yodo1MasBannerAdView bannerAdView) {
        if(adload == 0) {
            Map<String, String> arguments = new HashMap<>();
            channel.invokeMethod(YodoAdsConstants.BANNER_LOADED_METHOD, arguments);
            adload = 1;
        }
    }


    @Override
    public void onBannerAdOpened(Yodo1MasBannerAdView bannerAdView) {
        if(adopen == 0) {
            Log.d("yodo", "yodo banner is loaded ");
            Map<String, String> arguments = new HashMap<>();
            channel.invokeMethod(YodoAdsConstants.BANNER_OPEN_METHOD, arguments);
            adopen = 1;
        }

    }
    @Override
    public void onBannerAdFailedToLoad(Yodo1MasBannerAdView bannerAdView, @NonNull Yodo1MasError error) {

        if(adfail == 0) {
            if (bannerAdView != null) {
                Map<String, String> arguments = new HashMap<>();
                arguments.put(YodoAdsConstants.ERROR_MESSAGE_PARAMETER, error.getMessage());
                Log.d("yodo", "yodo banner is failed to load ");
                bannerAdView.destroy();
                channel.invokeMethod(YodoAdsConstants.BANNER_LOAD_ERROR_METHOD, arguments);
                adfail = 1;
            }
        }


    }
    @Override
    public void onBannerAdFailedToOpen(Yodo1MasBannerAdView bannerAdView, @NonNull Yodo1MasError error)
    {
        //Map<String, String> arguments = new HashMap<>();
        Map<String, String> arguments = new HashMap<>();
        arguments.put(YodoAdsConstants.ERROR_MESSAGE_PARAMETER, error.getMessage());
        channel.invokeMethod(YodoAdsConstants.BANNER_OPEN_ERROR_METHOD, arguments);
    }

    public void onBannerAdClosed(Yodo1MasBannerAdView bannerAdView)
    {
        if(adclose == 0) {
            if (bannerAdView != null) {
                Map<String, String> arguments = new HashMap<>();
                Log.d("yodo", "yodo banner is closed ");
                //bannerAdView.destroy();
                channel.invokeMethod(YodoAdsConstants.BANNER_CLOSE_METHOD, arguments);
                adclose = 1;
            }
        }
    }



}