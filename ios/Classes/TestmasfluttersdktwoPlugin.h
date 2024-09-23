#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN
@class BannerAdFactory;
@interface TestmasfluttersdktwoPlugin : NSObject<FlutterPlugin>

+ (TestmasfluttersdktwoPlugin *)sharedInstance;
- (void)buildWithController:(FlutterViewController *)controller;
- (void)initSdk:(NSString *)appKey privacy:(BOOL)privacy;

@end
NS_ASSUME_NONNULL_END
