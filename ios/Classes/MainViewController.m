// Ignore this file, not in use
#import "MainViewController.h"
#import "FlutterYodo1Mas.h"
@implementation MainViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    [[FlutterYodo1Mas sharedInstance] buildWithController:self];
}
@end