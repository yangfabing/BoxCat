//
//  ResultViewController.h
//  BoxCat
//
//  Created by 杨 发兵 on 13-11-8.
//  Copyright (c) 2013年 yfb. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GameViewController;
@interface ResultViewController : UIViewController


@property (nonatomic, assign) BOOL isSuccess;
@property (nonatomic, weak) GameViewController *gameController;


@property (weak, nonatomic) IBOutlet UIButton *totalScoreBtn;
@property (weak, nonatomic) IBOutlet UIButton *totalGoldBtn;

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *bestScoreLabel;



- (IBAction)onRestartClick:(id)sender;
- (IBAction)onContinueClick:(id)sender;

@end
