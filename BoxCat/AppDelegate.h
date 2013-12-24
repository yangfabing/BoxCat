//
//  AppDelegate.h
//  BoxCat
//
//  Created by 杨 发兵 on 13-10-14.
//  Copyright (c) 2013年 yfb. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GameViewController;
@class MainViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) MainViewController *viewController;
@end

