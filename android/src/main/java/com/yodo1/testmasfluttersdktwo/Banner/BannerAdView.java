package com.yodo1.testmasfluttersdktwo.banner;
import android.app.Activity;
import android.util.Log;
import android.view.View;


import com.yodo1.testmasfluttersdktwo.YodoAdsConstants;
import java.util.Map;
import com.yodo1.mas.Yodo1Mas;
import com.yodo1.mas.error.Yodo1MasError;
import com.yodo1.mas.event.Yodo1MasAdEvent;
import com.yodo1.mas.helper.model.Yodo1MasAdBuildConfig;
import com.yodo1.mas.banner.Yodo1MasBannerAdView;
import com.yodo1.mas.banner.Yodo1MasBannerAdSize;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;

public class BannerAdView implements PlatformView {
    //private static final UnityBannerSize STANDARD_SIZE = new UnityBannerSize(320, 50);
    //private final BannerView bannerView;
    public Yodo1MasBannerAdView bannerAdView;

    public BannerAdView(Activity activity, int id, Map<?, ?> args, BinaryMessenger messenger) {
        MethodChannel channel = new MethodChannel(messenger,
                YodoAdsConstants.BANNER_AD_CHANNEL + "_" + id);
        String bannerSize;
        bannerSize = (String)args.get(YodoAdsConstants.BANNER_SIZE);


        Log.d("yodo", "yodo calling banner ");
        //bannerView = new BannerView(activity, (String) args.get(UnityAdsConstants.PLACEMENT_ID_PARAMETER), size);
        bannerAdView = new Yodo1MasBannerAdView(activity);
        bannerAdView.setAdSize(getBannerSize(bannerSize));
        bannerAdView.setAdListener(new BannerAdListener(channel));
        bannerAdView.loadAd();

    }

    @Override
    public View getView() {
        return bannerAdView;
    }

    @Override
    public void dispose() {

    }

    private Yodo1MasBannerAdSize getBannerSize(String BannerSize)
    {
        switch(BannerSize)
        {
            case "Banner":
                return Yodo1MasBannerAdSize.Banner;
            case "AdaptiveBanner":
                return Yodo1MasBannerAdSize.AdaptiveBanner;
            case "LargeBanner":
                return Yodo1MasBannerAdSize.LargeBanner;
            case "SmartBanner":
                return Yodo1MasBannerAdSize.SmartBanner;
            case "IABMediumRectangle":
                return Yodo1MasBannerAdSize.IABMediumRectangle;
            default:
                return Yodo1MasBannerAdSize.Banner;
        }
    }
}