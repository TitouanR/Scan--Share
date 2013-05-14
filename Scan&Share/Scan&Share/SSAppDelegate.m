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

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    // Override point for customization after application launch.
//    UIViewController *root = [[UIViewController alloc] init];
//    [self.window setRootViewController:root];
//   // [[SSApi sharedApi] getProductWithEAN:@"3660140823951"];
//    [[SSApi sharedApi] getProductWithEAN:@"3660140823951" withCompletionBlockSucceed:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
//        SSProduct *product = (SSProduct *)[mappingResult.array objectAtIndex:0];
//        RKLogInfo(@"Load collection of Products: %@", product);
//    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
//         RKLogError(@"Operation failed with error: %@", error);
//    }];
//    self.window.backgroundColor = [UIColor whiteColor];
//    [self.window makeKeyAndVisible];
    
    SSMainViewController *tabBarController = (SSMainViewController *)self.window.rootViewController;
    [tabBarController setDelegate:self];
    [tabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"tabBar_Background1.png"]];
    [tabBarController.tabBar setSelectionIndicatorImage:[[UIImage alloc] init]];
   // [[[tabBarController.viewControllers objectAtIndex:1] tabBarItem] setFinishedSelectedImage:[UIImage imageNamed:@"searchIcon.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"searchIcon.png"]];
  

    
   
   //[[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabBarBackground2.png"]];
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
    NSLog(@"controller : %@", viewController);
    switch (tabBarController.selectedIndex) {
        case 0:
              [tabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"tabBar_Background2.png"]];
            break;
        case 1:
            [tabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"tabBar_Background3.png"]];
            break;
        case 2:
            [tabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"tabBar_Background1.png"]];
            break;
            
            
        default:
            [tabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"tabBar_Background1.png"]];
            break;
    }

}
@end
