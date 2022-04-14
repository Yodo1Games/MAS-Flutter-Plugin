#import "TestmasfluttersdktwoPlugin.h"
#if __has_include(<testmasfluttersdktwo/testmasfluttersdktwo-Swift.h>)
#import <testmasfluttersdktwo/testmasfluttersdktwo-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "testmasfluttersdktwo-Swift.h"
#endif

@implementation TestmasfluttersdktwoPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTestmasfluttersdktwoPlugin registerWithRegistrar:registrar];
}
@end
