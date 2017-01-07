//
//  AppDelegate.m
//  SuzukiOrderSystemServer
//
//  Created by Suzuki Hideharu on 2017/01/05.
//  Copyright © 2017年 SuzukiProduct. All rights reserved.
//

#import "AppDelegate.h"
#import "Define.h"
#import "MasterListViewController.h"
#import "TopViewController.h"
#import "ConnectionConditionView.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    /* window ViewController設定 -----------------------------------------------------------*/
    
    [self setWindow:[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]]];
    
    //NavigationBar 基本設定 (全てに適用)
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];    //navigationItem 色
    [[UINavigationBar appearance] setBarTintColor:BACKGROUND_COLOR_NAVIGATIONCONTROLLER]; //navigationBar 背景色
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}]; //navigationBar title 色
    
    //UISplitViewController 設定
    MasterListViewController *masterListViewController = [[MasterListViewController alloc] init];
    TopViewController        *topViewController        = [[TopViewController alloc] init];
    
    UINavigationController *masterNavController     = [[UINavigationController alloc] initWithRootViewController:masterListViewController];
    UINavigationController *detailNavViewController = [[UINavigationController alloc] initWithRootViewController:topViewController];
    
    
    UISplitViewController *splitViewController = [[UISplitViewController alloc] init];
    [[splitViewController view] setBackgroundColor:[UIColor clearColor]];
    [splitViewController setViewControllers:@[masterNavController,detailNavViewController]];
    [splitViewController setPreferredPrimaryColumnWidthFraction:RATIO_MASTER_WIDTH]; //マスタの画面幅に対するの比率
    
    [[self window] setBackgroundColor:BACKGROUND_COLOR_DEF_VIEWCONTROLLER];
    [[self window] setRootViewController:splitViewController];
    [[self window] makeKeyAndVisible];
    
    //通信状態を表すビューをウィンドウにセット
    ConnectionConditionView *connectionConditionView =
    [[ConnectionConditionView alloc] initWithFrame:CGRectMake(0, 20,
                                                              [[self window] bounds].size.width * RATIO_MASTER_WIDTH + 1,
                                                              44)];
    [[self window] addSubview:connectionConditionView];

    
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
