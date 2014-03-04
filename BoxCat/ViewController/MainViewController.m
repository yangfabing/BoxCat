//
//  MainViewController.m
//  BoxCat
//
//  Created by 杨 发兵 on 13-11-6.
//  Copyright (c) 2013年 yfb. All rights reserved.
//

#import "MainViewController.h"
#import "GameViewController.h"
#import "SettingViewController.h"

#import "UserData.h"

#import "GameCenterManager.h"

#import "LevelViewController.h"

@interface MainViewController ()<GameCenterManagerDelegate>

@end

@implementation MainViewController

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
    
    [[GameCenterManager sharedManager] setDelegate:self];
    
    // Array of leaderboard ID's to get high scores for
//    NSArray *leaderboardIDs = [NSArray arrayWithObjects:@"Leaderboard1", @"Leaderboard2", nil];
//    
//    // Returns a dictionary with leaderboard ID's as keys and high scores as values
//    NSDictionary *highScores = [[GameCenterManager sharedManager] highScoreForLeaderboards:leaderboardIDs];
    // Returns an integer value as a high scores
//    int highScore = [[GameCenterManager sharedManager] highScoreForLeaderboard:Leaderboard_ID];
//    NSLog(@"%d",highScore);
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)StartGame:(id)sender
{
    GameViewController *controller = [[GameViewController alloc] initWithNibName:@"GameViewController" bundle:nil];
    
    int level = [UserData sharedUserData].currentLevel;
    if (level == 0)
    {
        level = 1;
        [UserData sharedUserData].currentLevel = 1;
    }
    controller.currentLevel = level;
    [self.navigationController pushViewController:controller animated:YES];

}

- (IBAction)onSettingClick:(id)sender {
//    SettingViewController *controller =[[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:nil];
//    [self.navigationController pushViewController:controller animated:YES];
    
    //评分
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id799327232?mt=8"]]];
}

- (IBAction)onSearchLevelClick:(id)sender {
    
    LevelViewController *controller = [[LevelViewController alloc] initWithNibName:@"LevelViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}



#pragma mark - GameCenter Manager Delegate

- (void)gameCenterManager:(GameCenterManager *)manager authenticateUser:(UIViewController *)gameCenterLoginController {
    [self presentViewController:gameCenterLoginController animated:YES completion:^{
        NSLog(@"Finished Presenting Authentication Controller");
    }];
}

@end
