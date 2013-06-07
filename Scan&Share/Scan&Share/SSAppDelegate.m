//
//  SSAppDelegate.m
//  Scan&Share
//
//  Created by Karim CHEBBOUR on 01/05/13.
//  Copyright (c) 2013 Karim CHEBBOUR. All rights reserved.
//

#import "SSAppDelegate.h"
#import "SSApi.h"
#import <RestKit/RestKit.h>
#import "SSMainViewController.h"

@implementation SSAppDelegate

@synthesize token;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Setting Tab Bar
    SSMainViewController *tabBarController = (SSMainViewController *)self.window.rootViewController;
    [tabBarController setDelegate:self];
    [tabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"tabBar_Background.png"]];
    [tabBarController.tabBar setSelectionIndicatorImage:[[UIImage alloc] init]];
    [tabBarController setSelectedIndex:2];
    /*
    CGRect frame = tabBarController.tabBar.frame;
    frame.size.height -= 20;
    tabBarController.tabBar.frame = frame;
    */
    // Setting Nav Bar
    UIImage *navBackgroundImage = [UIImage imageNamed:@"navbar.png"];
    [[UINavigationBar appearance] setBackgroundImage:navBackgroundImage forBarMetrics:UIBarMetricsDefault];
//    UIImage *backButtonImage = [UIImage imageNamed:@"backButton.png"];
//    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage  forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    token = @"a8f153ae42f608d38e696478de6ebf3cf2c8a5893d743cb320ec3dd289f7c059c43148f403290fa04b31c4a7852dd54ec8d1c755b8315c7722d4d13e70251b76";
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

#pragma mark -
#pragma mark - UITabBarController Delegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    switch (tabBarController.selectedIndex) {
        case 0:
              [tabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"tabBar_Background1.png"]];
            break;
        case 1:
            [tabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"tabBar_Background2.png"]];
            break;
        case 2:
            [tabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"tabBar_Background.png"]];
            break;
        case 3:
            [tabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"tabBar_Background3.png"]];
            break;
        case 4:
            [tabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"tabBar_Background4.png"]];
            break;
            
            
        default:
            [tabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"tabBar_Background.png"]];
            break;
    }

}
@end
