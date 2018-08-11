//
//  AppDelegate.m
//  QiButton_UIControlEvents
//
//  Created by QiShare on 2018/8/6.
//  Copyright © 2018年 QiShare. All rights reserved.
//

#import "AppDelegate.h"
#import "QiButton_UIControlEventsViewController.h"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    _window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[QiButton_UIControlEventsViewController new]];
    [_window makeKeyAndVisible];
    
    return YES;
}

@end
