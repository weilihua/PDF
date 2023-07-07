//
//  AppDelegate.m
//  Demo
//
//  Created by weilihua on 2022/11/4.
//

#import "AppDelegate.h"
#import "SMHomeViewController.h"
#import <MMKV/MMKV.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    SMHomeViewController *vc = [SMHomeViewController new];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = navi;
    [self.window makeKeyAndVisible];
    
    //MMKV
    [self initMMKV];
    
    return YES;
}

- (void)initMMKV {
    // init MMKV in the main thread
    [MMKV initializeMMKV:nil];
}

@end
