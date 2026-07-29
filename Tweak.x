#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FLEXManager : NSObject
- (void)sharedManager;
- (void)showExplorer;
@end

%hook YTMAppDelegate
- (BOOL)application:(id)application didFinishLaunchingWithOptions:(id)launchOptions {
    BOOL didFinishLaunching = %orig;
    [[%c(FLEXManager) performSelector:@selector(sharedManager)] performSelector:@selector(showExplorer)];
    return didFinishLaunching;
}
- (void)appWillResignActive {
    %orig;
    [[%c(FLEXManager) performSelector:@selector(sharedManager)] performSelector:@selector(showExplorer)];
}
%end

%hook UIWindow
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    %orig;
    if (motion == UIEventSubtypeMotionShake) [[%c(FLEXManager) performSelector:@selector(sharedManager)] performSelector:@selector(showExplorer)];
}
%end