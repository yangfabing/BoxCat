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

#import "GameCenterManager.h"

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
        [self.gameController playAgain];
    }
}

- (IBAction)onContinueClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    if (self.gameController)
    {
        if ([UserData sharedUserData].currentLevel >= LEVELNUM)
        {
            [UserData sharedUserData].currentLevel = 1;
        }else
        {
            [UserData sharedUserData].currentLevel++;
        }
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
        [self.resultLabel setText:@"太棒啦"];
        [self.currentScoreLabel setHidden:NO];
        [self.currentScoreLabel setText:[NSString stringWithFormat:@"%d",[UserData sharedUserData].currentScore]];
        
        [self saveScoreToGameCenter];
    }else
    {
        [self.resultLabel setText:@"加油哦"];
        [self.currentScoreLabel setHidden:YES];
    }
    
//    [self.totalGoldBtn setTitle:[NSString stringWithFormat:@"金币：%d",[UserData sharedUserData].totalGold] forState:UIControlStateNormal];
     self.totalScoreLabel.text = [NSString stringWithFormat:@"%d",[UserData sharedUserData].totalScore];
    
    NSInteger bestScore = [[UserData sharedUserData] getCurrentBestScoreWithLevel:[UserData sharedUserData].currentLevel];
    NSInteger currentScore = [UserData sharedUserData].currentScore;
    [self.bestScoreLabel setText:[NSString stringWithFormat:@"%d",bestScore]];
    [self.currentScoreLabel setText:[NSString stringWithFormat:@"%d",currentScore]];
    if (bestScore < currentScore)
    {
        [[UserData sharedUserData] saveBestScore:currentScore withLevel:[UserData sharedUserData].currentLevel];
    }
}

//上传最高分到gamecenter
-(void)saveScoreToGameCenter
{
    BOOL isAvailable = [[GameCenterManager sharedManager] checkGameCenterAvailability];
    if (isAvailable) {
        [[GameCenterManager sharedManager] saveAndReportScore:[UserData sharedUserData].totalScore leaderboard:Leaderboard_ID  sortOrder:GameCenterSortOrderHighToLow];
    }

}
@end
