//
//  LevelViewController.m
//  BoxCat
//
//  Created by 杨 发兵 on 14-1-26.
//  Copyright (c) 2014年 yfb. All rights reserved.
//

#import "LevelViewController.h"
#import "LevelCell.h"

#import "UserData.h"
#import "GameViewController.h"

@interface LevelViewController ()

@end

@implementation LevelViewController

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
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"选择关卡";
    [self addLeftBtnWithStr:nil];
    [self installAllView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)installAllView
{
    NSInteger level = LEVELNUM;
    for (int i = 0; i < level; i++) {
        int x = i%4;
        int y = i/4;
        LevelCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"LevelCell" owner:self options:nil] lastObject];
        cell.levelLable .text = [NSString stringWithFormat:@"%d",i + 1];
        NSInteger bestScore = [[UserData sharedUserData] getCurrentBestScoreWithLevel:i + 1];
        cell.scoreLabel.text = [NSString stringWithFormat:@"%d",bestScore];
        [cell.levelBtn addTarget:self action:@selector(onLevelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.levelBtn setTag:i + 1];
        [cell setFrame:CGRectMake(5 + x*80, 100 + y*80, 70, 70)];
        [self.view addSubview:cell];
        
    }
}

-(void)onLevelBtnClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    NSLog(@"btn tag:%d",btn.tag);
    GameViewController *controller = [[GameViewController alloc] initWithNibName:@"GameViewController" bundle:nil];
    [UserData sharedUserData].currentLevel = btn.tag;
    [controller restartGameWithCurrentLevel:btn.tag];
    [self.navigationController pushViewController:controller animated:YES];

    
}
@end
