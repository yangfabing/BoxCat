//
//  AppDelegate.m
//  BoxCat
//
//  Created by 杨 发兵 on 13-10-14.
//  Copyright (c) 2013年 yfb. All rights reserved.
//

#import "AppDelegate.h"
#import "GameViewController.h"
#import "MainViewController.h"
#import "MobClick.h"


#import "GameCenterManager.h"
#import "MCSoundBoard.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    //开启友盟统计s
//    [MobClick startWithAppkey:UMENG_APPKEY reportPolicy:REALTIME channelId:nil];
//    [MobClick setLogEnabled:YES];
    

    //主程序视图加载
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:_viewController];
    navController.navigationBarHidden = YES;
     self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    
    [[GameCenterManager sharedManager] setupManager];
    [MCSoundBoard addSoundAtPath:[[NSBundle mainBundle] pathForResource:@"touch.wav" ofType:nil] forKey:@"touchSound"];
    
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


- (void) authenticateLocalPlayer
 {
    [[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:^(NSError *error){
         if (error == nil) {
             //成功处理
             NSLog(@"成功");
             NSLog(@"1--alias--.%@",[GKLocalPlayer localPlayer].alias);
           NSLog(@"2--authenticated--.%d",[GKLocalPlayer localPlayer].authenticated);
           NSLog(@"3--isFriend--.%d",[GKLocalPlayer localPlayer].isFriend);
            NSLog(@"4--playerID--.%@",[GKLocalPlayer localPlayer].playerID);
            NSLog(@"5--underage--.%d",[GKLocalPlayer localPlayer].underage);
         }else {
            //错误处理
            NSLog(@"失败  %@",error);
        }
     }];
 }

@end
