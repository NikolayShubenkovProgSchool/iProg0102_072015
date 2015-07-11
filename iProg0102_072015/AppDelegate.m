//
//  AppDelegate.m
//  iProg0102_072015
//
//  Created by Nikolay Shubenkov on 11/07/15.
//  Copyright (c) 2015 Nikolay Shubenkov. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self askForBadges];
    
    return YES;
}

- (void)askForBadges
{
    UIUserNotificationSettings* notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
}

@end
