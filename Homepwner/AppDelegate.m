//
//  AppDelegate.m
//  Homepwner
//
//  Created by Camron Schwoegler on 12/26/14.
//  Copyright (c) 2014 metafour.org. All rights reserved.
//

#import "AppDelegate.h"
#import "ItemsViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Override point for customization after application launch.
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  
  [self.window makeKeyAndVisible];
  
  ItemsViewController *ivc = [[ItemsViewController alloc] init];
//  [ivc setAutomaticallyAdjustsScrollViewInsets:NO];
  
  UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:ivc];
  
  // Neither of these moves the TableView down bellow the status bar
//  [ivc.view setBounds:CGRectMake(ivc.view.bounds.origin.x, ivc.view.bounds.origin.y, ivc.view.bounds.size.width, ivc.view.bounds.size.height - 50)];
//  [ivc.view setFrame:CGRectMake(ivc.view.frame.origin.x, ivc.view.frame.origin.y, ivc.view.frame.size.width, ivc.view.frame.size.height - 50)];
  
  [self.window setRootViewController:navController];
    
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

@end
