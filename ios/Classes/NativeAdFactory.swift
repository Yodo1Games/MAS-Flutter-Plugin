import Flutter
import Yodo1MasCore

@objc open class NativeAdFactory: NSObject, FlutterPlatformViewFactory {
    public var messenger: FlutterBinaryMessenger

    @objc init?(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    @objc public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }

    @objc public func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return NativeAdView(
            frame: frame,
            id: viewId,
            arguments: args,
            messenger: messenger)
    }

}
