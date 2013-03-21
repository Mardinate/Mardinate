//
//  OAppDelegate.m
//  MardinateTest
//

#import "OAppDelegate.h"
#import "OMardinateTestViewCon.h"

@implementation OAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[OMardinateTestViewCon alloc] init];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
