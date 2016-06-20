//
//  AppDelegate.m
//  TrafficBuddy
//
//  Created by Chandrasekhar Pasumarthi on 21/04/16.
//  Copyright © 2016 Testing. All rights reserved.
//

#import "AppDelegate.h"
#import "Utils.h"
#import "network.h"
#import <AWSCore/AWSCore.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.recentTrafficUpdates = [[NSMutableArray alloc] init];
    self.isFaceBookLoggedIn = false;
    AWSCognitoCredentialsProvider *credentialsProvider = [[AWSCognitoCredentialsProvider alloc] initWithRegionType:AWSRegionUSEast1
                                                                                                    identityPoolId:@"CognitoPoolID"];
    
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUSEast1
                                                                         credentialsProvider:credentialsProvider];
    
    AWSServiceManager.defaultServiceManager.defaultServiceConfiguration = configuration;
    
    
    UILocalNotification *localNotif = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    NSLog(@"launchOptions are %@",launchOptions);
    if (localNotif) {
        NSLog(@"localNotif is %@",localNotif);
    }
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
        // iOS 7.1 or earlier
        UIRemoteNotificationType allNotificationTypes =
        (UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge);
        [application registerForRemoteNotificationTypes:allNotificationTypes];
    } else {
        // iOS 8 or later
        // [END_EXCLUDE]
        UIUserNotificationType allNotificationTypes =
        (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings =
        [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    
//    [[UIApplication sharedApplication] registerForRemoteNotificationTypes: UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound];

    
    

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {

    network *networkObj = [network sharedManager];
    NSMutableDictionary *params =[[NSMutableDictionary alloc] init];
    
    NSString* newToken = [[[NSString stringWithFormat:@"%@",deviceToken]
                           stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] stringByReplacingOccurrencesOfString:@" " withString:@""];
//TODO: need to uncomment later for new devices
//    params[@"gcm_id"]=newToken;
//    params[@"app_ver"]=@"1.0";
//    params[@"device_id"]=@"notreg";
//    params[@"imei_no"]=@"ios";
//    
//    [networkObj getCabDetails:@"http://police.nayalabs.com/api/device_reg" params:params completionHandle:^(id response){
//        NSLog(@"reponse is %@", response);
//    }];
    
    
    NSLog(@"APN device token as string: %@", newToken);
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"Push received: %@", userInfo);
}


-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Registration for remote notification failed with error: %@", error.localizedDescription);
 
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))handler {
    NSLog(@"Notification received: %@", userInfo);
    UIApplicationState state = [application applicationState];
    
    
    [self.recentTrafficUpdates addObject:[[userInfo valueForKey:@"aps"] valueForKey:@"alert"]];
    NSLog(@"recent notifcaitons are %@", self.recentTrafficUpdates);
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateInactive) {
        
        NSLog(@"in UIApplicationStateInactive state ");
        //[[NSNotificationCenter defaultCenter] postNotificationName:@"inactivePush" object:nil];
        
        
    }else if (state == UIApplicationStateActive) {
        NSString *cancelTitle = @"Close";
        NSString *showTitle = @"Show";
        NSString *message = [[userInfo valueForKey:@"aps"] valueForKey:@"alert"];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Some title"
                                                            message:message
                                                           delegate:self
                                                  cancelButtonTitle:cancelTitle
                                                  otherButtonTitles:showTitle, nil];
        [alertView show];
    } else {
        
        int badgeCount = [UIApplication sharedApplication].applicationIconBadgeNumber;
        NSLog(@"badge count is %d", badgeCount);
        [UIApplication sharedApplication].applicationIconBadgeNumber = badgeCount+1;
        NSLog(@"badge count is %ld", (long)[UIApplication sharedApplication].applicationIconBadgeNumber);
        //Do stuff that you would do if the application was not active
    }
}



- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void  (^)(UIBackgroundFetchResult))completionHandler
{
    // Start asynchronous NSOperation, or some other check
    
    // Ideally the NSOperation would notify when it has completed, but just for
    // illustrative purposes, call the completion block after 20 seconds.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 20 * NSEC_PER_SEC),
                   dispatch_get_main_queue(), ^{
                       // Check result of your operation and call completion block with the result
                       completionHandler(UIBackgroundFetchResultNewData);
                       NSLog(@"Testing background method");
                   });
}

@end
