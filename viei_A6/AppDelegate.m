//
//  AppDelegate.m
//  viei_A6
//
//  Created by Vieira Jason 070569870 on 3/5/13.
//  Copyright (c) 2013 Hoang Chinh. All rights reserved.
//

#import "AppDelegate.h"
#import "CBCNewsFeed.h"
#import "GMNewsFeed.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /*
    CBCNewsFeed *cnf = [[CBCNewsFeed alloc] initWithStyle:UITableViewStylePlain];
    GMNewsFeed *gnf = [[GMNewsFeed alloc] initWithStyle:UITableViewStylePlain];
    // Create the tabBarController
    
    // Make an array containing the two view controllers
   
    UINavigationController *nav1 =[[UINavigationController alloc] initWithRootViewController:cnf];
    UINavigationController *nav2 =[[UINavigationController alloc] initWithRootViewController:gnf];
    NSArray *navControllers = [NSArray arrayWithObjects:nav1, nav2, nil];
    UITabBarController *masterTab = [[UITabBarController alloc] init];
    [masterTab setViewControllers:navControllers];
    [[self window] setRootViewController: masterTab];
    [[self window] makeKeyAndVisible];
    //WebViewVieiController *wvc = [[WebViewVieiController alloc] init];
    //[lvc setWebViewController:wvc];
     
    */
    // Override point for customization after application launch.
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
