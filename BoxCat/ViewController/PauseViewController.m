//
//  PauseViewController.m
//  BoxCat
//
//  Created by 杨 发兵 on 13-11-8.
//  Copyright (c) 2013年 yfb. All rights reserved.
//

#import "PauseViewController.h"

@interface PauseViewController ()

@end

@implementation PauseViewController

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

- (IBAction)onCancelClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onRestartClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];

    
}

- (IBAction)onMainClick:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
