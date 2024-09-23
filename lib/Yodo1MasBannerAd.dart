import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui';

import 'constants.dart';

class Yodo1MASBannerAd extends StatefulWidget {
  /// Unity Ad Placement ID

  /// Size of the banner ad.
  final BannerSize size;

  /// Called when the banner is loaded and ready to be placed in the view hierarchy.
  final void Function()? onLoad;

  /// Called when the user clicks the banner.
  final void Function()? onOpen;
  final void Function()? onClosed;

  /// Called when unity ads banner encounters an error.
  final void Function(
       String errorMessage)?
  onLoadFailed;

  final void Function(
      String errorMessage)?
  onOpenFailed;

  /// This widget is used to contain Banner Ads.
  const Yodo1MASBannerAd({
    Key? key,
    this.size= BannerSize.Banner,
    this.onLoad,
    this.onOpen,
    this.onClosed,
    this.onLoadFailed,
    this.onOpenFailed,
  }) : super(key: key);

  @override
  _Yodo1MASBannerAdState createState() => _Yodo1MASBannerAdState();
}

class _Yodo1MASBannerAdState extends State<Yodo1MASBannerAd> {
  bool _isLoaded = false;

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return SizedBox(
        height: widget.size.height + 0.0,
        width: widget.size.width + 0.0,
        child: OverflowBox(
          maxHeight: _isLoaded ? widget.size.height + 0.0 : 1,
          minHeight: 0.1,
          alignment: Alignment.center,
          child: AndroidView(
            viewType: bannerAdChannel,
            creationParams: <String, dynamic>{
              bannersize : widget.size.size,
            },
            creationParamsCodec: const StandardMessageCodec(),
            onPlatformViewCreated: _onBannerAdViewCreated,
          ),
        ),
      );
    }
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return SizedBox(
          height: widget.size.height + 0.0,
          width: widget.size.width + 0.0,
          child: OverflowBox(
            maxHeight: _isLoaded ? widget.size.height + 0.0 : 1,
            minHeight: 0.1,
            alignment: Alignment.center,

            child: UiKitView(

              viewType: bannerAdChannel,
              creationParams: <String, dynamic>{
                bannersize: widget.size.size,
              },

              creationParamsCodec: const StandardMessageCodec(),
              onPlatformViewCreated: _onBannerAdViewCreated,
            ),
          )
      );
    }


    return Container();
  }

  void _onBannerAdViewCreated(int id) {
    final channel = MethodChannel('${bannerAdChannel}_$id');

    channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case bannerLoadErrorMethod:
          widget.onLoadFailed?.call(
            call.arguments[errorMessageParameter],
          );
          break;
        case bannerOpenErrorMethod:
          widget.onOpenFailed?.call(
            call.arguments[errorMessageParameter],
          );
          break;
        case bannerLoadedMethod:
          widget.onLoad?.call();
          setState(() {
            _isLoaded = true;
          });
          break;
        case bannerOpenMethod:
          widget.onOpen?.call();
          break;
        case bannerCloseMethod:
          widget.onClosed?.call();
          break;
      }
    });
  }

}

/// Defines the size of Banner Ad.
class BannerSize {
  final String size;
  final int width;
  final int height;
  static var pixelRatio = window.devicePixelRatio;
  static var logicalScreenSize = window.physicalSize / pixelRatio;
  static int logicalWidth = logicalScreenSize.width.round();
  static int widthvalue = logicalWidth;

  static const BannerSize Banner = BannerSize(size: "Banner",width: 320, height: 50);
  static BannerSize LargeBanner = BannerSize(size: "LargeBanner",width: 320, height: 100);
  static BannerSize IABMediumRectangle= BannerSize(size: "IABMediumRectangle",width: 300, height: 250);
  static BannerSize SmartBanner= BannerSize(size: "SmartBanner",width : widthvalue, height: 50);
  static BannerSize AdaptiveBanner= BannerSize(size: "AdaptiveBanner",width: widthvalue, height: 90);

  const BannerSize({this.width = 320, this.height = 50,this.size = "Banner"});


}

enum BannerAdState {
  /// Banner is loaded.
  loaded,

  /// Banner is clicked.
  opened,

  /// Error during loading banner
  loaderror,
  openerror,
  closed,
}


