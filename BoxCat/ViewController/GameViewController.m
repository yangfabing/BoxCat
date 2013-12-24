//
//  ViewController.m
//  BoxCat
//
//  Created by 杨 发兵 on 13-10-14.
//  Copyright (c) 2013年 yfb. All rights reserved.
//

#import "GameViewController.h"
#import "DotsScene.h"
#import "PauseViewController.h"
#import "ResultViewController.h"
#import "UserData.h"

@interface GameViewController ()<DotsResultDelegate>
{
    
    NSInteger redDotsCount;
    NSInteger currentScore;
    
}

@property (nonatomic, strong) DotsScene *scene;
@end

@implementation GameViewController


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

//    self.scene = [[DotsScene alloc] initWithSize:CGSizeMake(320, 320)];
//    NSArray *tempArray = [[UserData sharedUserData] getRedDotsWithLevel:1];
//    [_scene installAllDotWithArray:tempArray];
//    _scene.delegate = self;
//    [self.view addSubview:_scene];
    
    
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)onPauseClick:(id)sender
{
    PauseViewController *controller = [[PauseViewController alloc] initWithNibName:@"PauseViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
    
}


#pragma mark - 
#pragma mark - Custom Methods

-(void)restartGameWithCurrentLevel:(NSInteger)level
{
    if (self.scene)
    {
        [self.scene removeFromSuperview];
        self.scene.delegate = nil;
    }
    
    self.scene = [[DotsScene alloc] initWithSize:CGSizeMake(320, 320)];
    NSArray *tempArray = [[UserData sharedUserData] getRedDotsWithLevel:level];
    
    redDotsCount = tempArray.count;
    
    [_scene installAllDotWithArray:tempArray];
    _scene.delegate = self;
    [self.view addSubview:_scene];
    
    [self refreshScore];
}


//刷新分数
-(void)refreshScore
{
    currentScore = (81 - redDotsCount);
    self.scoreLabel.text = [NSString stringWithFormat:@"%d",currentScore];
    [self randomRefreshGold];
}


//随机给予用户金币
-(void)randomRefreshGold
{
    NSInteger rand = arc4random()%10;
    if (rand == 1) {
        [UserData sharedUserData].totalGold += 5;
    }
    
    [self.goldLabel setText:[NSString stringWithFormat:@"%d",[UserData sharedUserData].totalGold]];
}

#pragma mark - 
#pragma mark - DotsResultDelegate Methods

-(void)didTouchDot
{
    redDotsCount++;
    [self refreshScore];
}


-(void)didSuccessed
{
    [UserData sharedUserData].currentScore = currentScore;
    
    NSInteger bestScore = [[UserData sharedUserData] getCurrentBestScoreWithLevel:[UserData sharedUserData].currentLevel];
    if (bestScore < currentScore) {
        [UserData sharedUserData].totalScore += (currentScore - bestScore);
    }
    
    [[UserData sharedUserData] saveUserData];
    [UIView animateWithDuration:1.0f animations:^{
        [self.scene setAlpha:0];
        
    }completion:^(BOOL finish)
    {
        [self.scene removeFromSuperview];
        ResultViewController *controller = [[ResultViewController alloc] initWithNibName:@"ResultViewController" bundle:nil];
        controller.gameController = self;
        controller.isSuccess = YES;
        
        [self.navigationController pushViewController:controller animated:YES];
    }];
}


-(void)didFailed
{
    [[UserData sharedUserData] saveUserData];

    [UIView animateWithDuration:1.0f animations:^{
        
        [self.scene setAlpha:0];
        
    }completion:^(BOOL finish)
     {
         [self.scene removeFromSuperview];
         ResultViewController *controller = [[ResultViewController alloc] initWithNibName:@"ResultViewController" bundle:nil];
         controller.gameController = self;
         [self.navigationController pushViewController:controller animated:YES];
     }];
}
@end
