package com.yodo1.testmasfluttersdktwo.nativead;
import android.app.Activity;
import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Context;
import android.content.res.Resources;
import android.os.Bundle;
import android.util.TypedValue;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;


import com.yodo1.testmasfluttersdktwo.YodoAdsConstants;
import java.util.Map;
import com.yodo1.mas.Yodo1Mas;
import com.yodo1.mas.error.Yodo1MasError;
import com.yodo1.mas.event.Yodo1MasAdEvent;
import com.yodo1.mas.helper.model.Yodo1MasAdBuildConfig;
import com.yodo1.mas.nativeads.Yodo1MasNativeAdListener;
import com.yodo1.mas.nativeads.Yodo1MasNativeAdView;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;



public class NativeAdView implements PlatformView {

    public Yodo1MasNativeAdView nativeAdView;

    public NativeAdView(Activity activity, int id, Map<?, ?> args, BinaryMessenger messenger) {
        MethodChannel channel = new MethodChannel(messenger,
                YodoAdsConstants.NATIVE_AD_CHANNEL + "_" + id);
        String nativeSize,nativeColor;
        //int nativeSizeY;
        nativeSize = (String)args.get(YodoAdsConstants.NATIVE_SIZE);
        //nativeSizeY = (int)args.get(YodoAdsConstants.BANNER_SIZE_Y);
        nativeColor = (String)args.get(YodoAdsConstants.NATIVE_COLOR);



        //bannerView = new BannerView(activity, (String) args.get(UnityAdsConstants.PLACEMENT_ID_PARAMETER), size);
        nativeAdView = new Yodo1MasNativeAdView(activity);
        nativeAdView.setAdBackgroundColor(nativeColor);
        nativeAdView.setAdListener(new NativeAdListener(channel));
        nativeAdView.setLayoutParams(new ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, dp2px(getNativeSize(nativeSize))));
        nativeAdView.loadAd();

    }

    public static int dp2px(int dp) {
        return (int) (dp * Resources.getSystem().getDisplayMetrics().density);
    }


    @Override
    public View getView() {
        return nativeAdView;
    }

    @Override
    public void dispose() {

    }
    private int getNativeSize(String NativeSize)
    {
        switch(NativeSize)
        {
            case "NativeSmall":
                return 300;
            case "Nativelarge":
                return 600;
            default:
                return 300;
        }
    }


}


