//
//  MainViewController.m
//  BoxCat
//
//  Created by 杨 发兵 on 13-11-6.
//  Copyright (c) 2013年 yfb. All rights reserved.
//

#import "MainViewController.h"
#import "GameViewController.h"
#import "UserData.h"

@interface MainViewController ()

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
    // Do any additional setup after loading the view from its nib.
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
    [controller restartGameWithCurrentLevel:level];
    [self.navigationController pushViewController:controller animated:YES];
}
@end
