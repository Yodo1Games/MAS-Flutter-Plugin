import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui';

import 'constants.dart';

class Yodo1MASNativeAd extends StatefulWidget {
  /// Unity Ad Placement ID

  /// Size of the Native ad.
  final NativeSize size;
  final String backgroundColor;

  /// Called when the Native is loaded and ready to be placed in the view hierarchy.
  final void Function()? onLoad;

  /// Called when the user clicks the Native.

  final void Function()? onClosed;

  /// Called when unity ads Native encounters an error.
  final void Function(
      String errorMessage)?
  onLoadFailed;


  /// This widget is used to contain Native Ads.
  const Yodo1MASNativeAd({
    Key? key,
    this.size= NativeSize.NativeSmall,
    this.backgroundColor = "",
    this.onLoad,
    this.onClosed,
    this.onLoadFailed,

  }) : super(key: key);

  @override
  _Yodo1MASNativeAdState createState() => _Yodo1MASNativeAdState();
}

class _Yodo1MASNativeAdState extends State<Yodo1MASNativeAd> {
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
            viewType: nativeAdChannel,
            creationParams: <String, dynamic>{
              nativesize : widget.size.size,
              nativecolor: widget.backgroundColor,
            },
            creationParamsCodec: const StandardMessageCodec(),
            onPlatformViewCreated: _onNativeAdViewCreated,
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

              viewType: nativeAdChannel,
              creationParams: <String, dynamic>{
                nativesize: widget.size.size,
                nativecolor: widget.backgroundColor,
              },
              creationParamsCodec: const StandardMessageCodec(),
              onPlatformViewCreated: _onNativeAdViewCreated,
            ),
          )
      );
    }


    return Container();
  }

  void _onNativeAdViewCreated(int id) {
    final channel = MethodChannel('${nativeAdChannel}_$id');

    channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case nativeLoadErrorMethod:
          widget.onLoadFailed?.call(
            call.arguments[errorMessageParameter],
          );
          break;

        case nativeLoadedMethod:
          widget.onLoad?.call();
          setState(() {
            _isLoaded = true;
          });
          break;
        case nativeCloseMethod:
          widget.onClosed?.call();
          break;
      }
    });
  }

}

/// Defines the size of Native Ad.
class NativeSize {
  final String size;
  final int width;
  final int height;

  static const NativeSize NativeSmall = NativeSize(size: "NativeSmall",width: 300,height: 100);
  static NativeSize NativeLarge = NativeSize(size: "NativeLarge",width: 600,height: 500);


  const NativeSize({this.width = 300, this.height = 100,this.size = "NativeSmall"});


}

enum NativeAdState {
  /// Native is loaded.
  loaded,

  /// Native is clicked.


  /// Error during loading Native
  loaderror,

  closed,
}


