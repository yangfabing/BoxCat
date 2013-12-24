//
//  ResultViewController.m
//  BoxCat
//
//  Created by 杨 发兵 on 13-11-8.
//  Copyright (c) 2013年 yfb. All rights reserved.
//

#import "ResultViewController.h"
#import "GameViewController.h"
#import "UserData.h"

@interface ResultViewController ()

@end

@implementation ResultViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self installViews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onRestartClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    if (self.gameController)
    {
        NSInteger level = [UserData sharedUserData].currentLevel;
        [self.gameController restartGameWithCurrentLevel:level];
    }
}

- (IBAction)onContinueClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    if (self.gameController)
    {
       [UserData sharedUserData].currentLevel++;
        NSInteger level = [UserData sharedUserData].currentLevel;
        [self.gameController restartGameWithCurrentLevel:level];
    }

}



#pragma mark -
#pragma mark - Custom Methods

-(void)installViews
{
    if (self.isSuccess)
    {
        [self.resultLabel setText:@"太棒了"];
        [self.currentScoreLabel setHidden:NO];
        [self.currentScoreLabel setText:[NSString stringWithFormat:@"本次得分：%d",[UserData sharedUserData].currentScore]];
    }else
    {
        [self.resultLabel setText:@"失败啦"];
        [self.currentScoreLabel setHidden:YES];
    }
    
    [self.totalGoldBtn setTitle:[NSString stringWithFormat:@"金币：%d",[UserData sharedUserData].totalGold] forState:UIControlStateNormal];
     [self.totalScoreBtn setTitle:[NSString stringWithFormat:@"总分数：%d",[UserData sharedUserData].totalScore] forState:UIControlStateNormal];
    
    NSInteger bestScore = [[UserData sharedUserData] getCurrentBestScoreWithLevel:[UserData sharedUserData].currentLevel];
    NSInteger currentScore = [UserData sharedUserData].currentScore;
    [self.bestScoreLabel setText:[NSString stringWithFormat:@"个人历史最佳得分：%d",bestScore]];
    [self.currentScoreLabel setText:[NSString stringWithFormat:@"本次得分：%d",currentScore]];
    if (bestScore < currentScore)
    {
        [[UserData sharedUserData] saveBestScore:currentScore withLevel:[UserData sharedUserData].currentLevel];
    }
}
@end
