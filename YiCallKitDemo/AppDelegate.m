//
//  AppDelegate.m
//  YiCallKitDemo
//
//  Created by Developer_Yi on 2017/2/15.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "AppDelegate.h"
#import <CallKit/CallKit.h>
#import "MBProgressHUD+NJ.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
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
    [MBProgressHUD showMessage:@"检查授权状态中"];
    CXCallDirectoryManager *manager = [CXCallDirectoryManager sharedInstance];
    // 获取权限状态
    [manager getEnabledStatusForExtensionWithIdentifier:@"com.mac.YiCallKitDemo.YiCallKitDemoExtension" completionHandler:^(CXCallDirectoryEnabledStatus enabledStatus, NSError * _Nullable error) {
        if (!error) {
            NSString *title = nil;
            if (enabledStatus == CXCallDirectoryEnabledStatusDisabled) {
                /*
                 CXCallDirectoryEnabledStatusUnknown = 0,
                 CXCallDirectoryEnabledStatusDisabled = 1,
                 CXCallDirectoryEnabledStatusEnabled = 2,
                 */
                title = @"未授权，请在设置->电话授权相关权限";
            }else if (enabledStatus == CXCallDirectoryEnabledStatusEnabled) {
                
            }else if (enabledStatus == CXCallDirectoryEnabledStatusUnknown) {
                title = @"未知的授权状态";
            }
            [MBProgressHUD hideHUD];
            UIAlertView *view=[[UIAlertView alloc]initWithTitle:@"提示" message:title delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [view show];
        }else{
            [MBProgressHUD hideHUD];
            UIAlertView *view=[[UIAlertView alloc]initWithTitle:@"提示" message:@"系统错误，建议等待iOS系统修复" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [view show];
        }
    }];

}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
