// this class register the banner ad view and have implementation for initialization and other ad types.
#import "TestmasfluttersdktwoPlugin.h"
#import <Yodo1MasCore/Yodo1Mas.h>
#import <YYModel/YYModel.h>
#import <yodo1mas/yodo1mas-Swift.h>

#define CHANNEL @"com.yodo1.mas/sdk"
#define METHOD_NATIVE_INIT_SDK @"native_init_sdk"
#define METHOD_NATIVE_IS_AD_LOADED @"native_is_ad_loaded"
#define METHOD_NATIVE_LOAD_AD @"native_load_ad"
#define METHOD_NATIVE_SHOW_AD @"native_show_ad"
#define METHOD_DISMISS_BANNER @"dismiss_banner"
#define METHOD_FLUTTER_INIT_EVENT @"flutter_init_event"
#define METHOD_FLUTTER_AD_EVENT @"flutter_ad_event"

@interface TestmasfluttersdktwoPlugin () <Yodo1MasRewardAdDelegate, Yodo1MasInterstitialAdDelegate, Yodo1MasBannerAdDelegate>
@property (nonatomic, strong) UIViewController *controller;
@property (nonatomic, weak) FlutterMethodChannel *channel;
@end

@implementation TestmasfluttersdktwoPlugin

FlutterMethodChannel *channel;

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    channel = [FlutterMethodChannel methodChannelWithName:CHANNEL binaryMessenger:[registrar messenger]];
    TestmasfluttersdktwoPlugin *instance = [[TestmasfluttersdktwoPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];

    BannerAdFactory *bannerAdFactory = [[BannerAdFactory alloc] yy_modelInitWithCoder:[registrar messenger]];
    [registrar registerViewFactory:bannerAdFactory withId:@"com.yodo1.mas/sdk/bannerAd"];

    NativeAdFactory *nativeAdFactory = [[NativeAdFactory alloc] yy_modelInitWithCoder:[registrar messenger]];
    [registrar registerViewFactory:nativeAdFactory withId:@"com.yodo1.mas/sdk/nativeAd"];
}

+ (TestmasfluttersdktwoPlugin *)sharedInstance {
    static TestmasfluttersdktwoPlugin *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[TestmasfluttersdktwoPlugin alloc] init];
    });
    return _instance;
}

- (instancetype)init {
    self = [super init];
    return self;
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    __weak __typeof(self) weakSelf = self;
    NSLog(@"Method Called - %@", call.method);
    if (call.method) {
        if ([call.method isEqualToString:METHOD_NATIVE_INIT_SDK]) {
            NSString *appKey = call.arguments[@"app_key"];
            NSString *privacy = call.arguments[@"privacy"];
            BOOL ccpa = [call.arguments[@"ccpa"] boolValue];
            BOOL coppa = [call.arguments[@"coppa"] boolValue];
            BOOL gdpr = [call.arguments[@"gdpr"] boolValue];
            if (appKey) {
                [Yodo1MasAppOpenAd sharedInstance].autoDelayIfLoadFail = YES;
                [Yodo1MasInterstitialAd sharedInstance].autoDelayIfLoadFail = YES;
                [Yodo1MasRewardAd sharedInstance].autoDelayIfLoadFail = YES;
                [weakSelf initSdk:appKey privacy:privacy ccpa:ccpa coppa:coppa gdpr:gdpr];
                result(@1);
            }
        } else if ([call.method isEqualToString:METHOD_NATIVE_LOAD_AD]) {
            NSString *type = call.arguments[@"ad_type"];
            if (type) {
                if ([type isEqualToString:@"Reward"]) {
                    [[Yodo1MasRewardAd sharedInstance] loadAd];
                } else if ([type isEqualToString:@"Interstitial"]) {
                    [[Yodo1MasInterstitialAd sharedInstance] loadAd];
                } else if ([type isEqualToString:@"Banner"]) {
                    // isAdLoaded = [[Yodo1Mas sharedInstance] isBannerAdLoaded];
                } else if ([type isEqualToString:@"AppOpen"]) {
                    [[Yodo1MasAppOpenAd sharedInstance] loadAd];
                }
            }
        } else if ([call.method isEqualToString:METHOD_NATIVE_IS_AD_LOADED]) {
            BOOL isAdLoaded = NO;
            NSString *type = call.arguments[@"ad_type"];
            if (type) {
                if ([type isEqualToString:@"Reward"]) {
                    isAdLoaded = [[Yodo1MasRewardAd sharedInstance] isLoaded];
                } else if ([type isEqualToString:@"Interstitial"]) {
                    isAdLoaded = [[Yodo1MasInterstitialAd sharedInstance] isLoaded];
                } else if ([type isEqualToString:@"Banner"]) {
                    // isAdLoaded = [[Yodo1Mas sharedInstance] isBannerAdLoaded];
                } else if ([type isEqualToString:@"AppOpen"]) {
                    isAdLoaded = [[Yodo1MasAppOpenAd sharedInstance] isLoaded];
                }
            }
            result(@(isAdLoaded));
        } else if ([call.method isEqualToString:METHOD_DISMISS_BANNER]) {
            // [[Yodo1Mas sharedInstance] dismissBannerAd];
            result(nil);
        } else if ([call.method isEqualToString:METHOD_NATIVE_SHOW_AD]) {
            NSLog(@"Show Ad - %@", call.arguments);
            NSString *type = call.arguments[@"ad_type"];
            NSString *placementId = call.arguments[@"placement_id"];
            if (type) {
                if ([type isEqualToString:@"Reward"]) {
                    if (placementId) {
                        [[Yodo1MasRewardAd sharedInstance] showAdWithPlacement:placementId];
                    } else {
                        [[Yodo1MasRewardAd sharedInstance] showAd];
                    }
                } else if ([type isEqualToString:@"Interstitial"]) {
                    if (placementId) {
                        [[Yodo1MasInterstitialAd sharedInstance] showAdWithPlacement:placementId];
                    } else {
                        [[Yodo1MasInterstitialAd sharedInstance] showAd];
                    }
                } else if ([type isEqualToString:@"Banner"]) {
                    // [[Yodo1Mas sharedInstance] showBannerAd];
                } else if ([type isEqualToString:@"AppOpen"]) {
                    if (placementId) {
                        [[Yodo1MasAppOpenAd sharedInstance] showAdWithPlacement:placementId];
                    } else {
                        [[Yodo1MasAppOpenAd sharedInstance] showAd];
                    }
                }
            }
            result(nil);
        } else {
            result(FlutterMethodNotImplemented);
        }
    } else {
        result(FlutterMethodNotImplemented);
    }
}

- (void)initSdk:(NSString *)appKey privacy:(BOOL)privacy ccpa:(BOOL)ccpa coppa:(BOOL)coppa gdpr:(BOOL)gdpr {
    __weak __typeof(self) weakSelf = self;
    Yodo1MasAdBuildConfig *config = [Yodo1MasAdBuildConfig instance];
    if (privacy) {
        config.enableUserPrivacyDialog = privacy;
    }
    [Yodo1Mas sharedInstance].isCCPADoNotSell = ccpa; 
    [Yodo1Mas sharedInstance].isCOPPAAgeRestricted = coppa; // New parameter
    [Yodo1Mas sharedInstance].isGDPRUserConsent = gdpr; // New parameter
    [[Yodo1Mas sharedInstance] setAdBuildConfig:config];
    [[Yodo1Mas sharedInstance] initMasWithAppKey:appKey successful:^{
        if (channel) {
            NSDictionary *json = @{@"successful" : @(YES)};
            [channel invokeMethod:METHOD_FLUTTER_INIT_EVENT arguments:json];
        }
    } fail:^(Yodo1MasError *error) {
        if (channel) {
            NSDictionary *json = @{@"successful" : @(NO), @"error" : [error getJsonObject]};
            [channel invokeMethod:METHOD_FLUTTER_INIT_EVENT arguments:json];
        }
    }];
}

- (void)loadAppOpenAds {
    __weak __typeof(self) weakSelf = self;
    [Yodo1MasAppOpenAd sharedInstance].adDelegate = weakSelf;
    [[Yodo1MasAppOpenAd sharedInstance] loadAd];
}


- (void)showAppOpenAds:(NSString * _Nullable)placementId {
    if (placementId) {
        NSLog(@"Showing App Open Ad with placement ID: %@", placementId);
        [[Yodo1MasAppOpenAd sharedInstance] showAdWithPlacement:placementId];
    } else {
        NSLog(@"Showing App Open Ad without placement ID");
        [[Yodo1MasAppOpenAd sharedInstance] showAd];
    }
}


#pragma mark - Yodo1Masdelegate
- (void)onAdOpened:(Yodo1MasAdEvent *)event {
    if (channel) {
        [channel invokeMethod:METHOD_FLUTTER_AD_EVENT arguments:[event getJsonObject]];
    }
}

- (void)onAdClosed:(Yodo1MasAdEvent *)event {
    if (channel) {
        [channel invokeMethod:METHOD_FLUTTER_AD_EVENT arguments:[event getJsonObject]];
    }
}

- (void)onAdError:(Yodo1MasAdEvent *)event error:(Yodo1MasError *)error {
    if (channel) {
        [channel invokeMethod:METHOD_FLUTTER_AD_EVENT arguments:[event getJsonObject]];
    }
}

- (void)onAdRewardEarned:(Yodo1MasAdEvent *)event {
    [channel invokeMethod:METHOD_FLUTTER_AD_EVENT arguments:[event getJsonObject]];
}
@end
