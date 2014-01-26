//
//  PauseViewController.h
//  BoxCat
//
//  Created by 杨 发兵 on 13-11-8.
//  Copyright (c) 2013年 yfb. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GameViewController;
@interface PauseViewController : UIViewController

@property (nonatomic, weak) GameViewController *gameController;


- (IBAction)onCancelClick:(id)sender;
- (IBAction)onRestartClick:(id)sender;
- (IBAction)onMainClick:(id)sender;

@end
