//
//  AppDelegate.m
//  GCTNavigationDemo
//
//  Created by 罗树新 on 2018/4/7.
//  Copyright © 2018年 GCT. All rights reserved.
//

#import "AppDelegate.h"
#import "GCTNavigation.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [UINavigationController gct_setForceAppFullScreenPopEnable:YES];
    GCTUINavigationBar *appearance = [GCTUINavigationBar appearance];
    appearance.titleTextColor = [UIColor redColor];
    [appearance setBarButtonTextColor:[UIColor colorWithWhite:0 alpha:0.8] forControlState:UIControlStateNormal];
    
    UIImage *image = [UIImage imageNamed:@"navigationBar_back_normal"];
    [appearance setImage:image forNavigationBarButtonType:GCTUINavigationBarButtonTypeBack controlState:UIControlStateNormal];
    [appearance setImage:[UIImage imageNamed:@"navigationBar_back_highlight"] forNavigationBarButtonType:GCTUINavigationBarButtonTypeBack controlState:UIControlStateHighlighted];
    [appearance setImage:[UIImage imageNamed:@"navigationBar_close_normal"] forNavigationBarButtonType:GCTUINavigationBarButtonTypeClose controlState:UIControlStateNormal];
    [appearance setImage:[UIImage imageNamed:@"navigationBar_close_highlight"] forNavigationBarButtonType:GCTUINavigationBarButtonTypeBack controlState:UIControlStateHighlighted];
    appearance.titleFont = [UIFont systemFontOfSize:20];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
