//
//  RUDDERAppDelegate.m
//  Rudder-Adjust
//
//  Created by arnab on 10/29/2019.
//  Copyright (c) 2019 arnab. All rights reserved.
//

#import "RUDDERAppDelegate.h"
#import <Rudder/Rudder.h>
#import <RudderAdjustFactory.h>


@implementation RUDDERAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    NSString *writeKey = @"<write_key>";
    NSString *dataPlaneUrl = @"<dataPlane_url>";
    
    RSConfigBuilder *configBuilder = [[RSConfigBuilder alloc] init];
    [configBuilder withDataPlaneUrl:dataPlaneUrl];
    [configBuilder withLoglevel:RSLogLevelDebug];
    [configBuilder withFactory:[RudderAdjustFactory instance]];
    RSClient *rudderClient = [RSClient getInstance:writeKey config:[configBuilder build]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"processor started");
        
        usleep(10000000);
        [rudderClient identify:@"RudderStack iOS user id"];
        [rudderClient track:@"Track event iOS" properties:@{
            @"key1": @"value1",
            @"key2": @123,
            @"key3": @YES,
            @"key4": @4.56,
            @"revenue": @"4.99",
            @"currency": @"USD"
        }];
    });
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
