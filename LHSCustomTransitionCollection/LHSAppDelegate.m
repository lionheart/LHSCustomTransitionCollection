//
//  LHSAppDelegate.m
//  LHS Custom Transition Collection
//
//  Created by Dan Loewenherz on 12/28/13.
//  Copyright (c) 2013 Lionheart Software LLC. All rights reserved.
//

#import "LHSAppDelegate.h"

@implementation LHSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
