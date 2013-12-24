//
//  BaseNavViewController.m
//  ChenShiTaiJi
//
//  Created by 杨 发兵 on 13-10-10.
//  Copyright (c) 2013年 yfb. All rights reserved.
//

#import "BaseNavViewController.h"

@interface BaseNavViewController ()
{
    BOOL isVideoFullscreen;
}

@end

@implementation BaseNavViewController

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
    self.navigationBarHidden = YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait)
    {
        return YES;
    }
    
    return NO;
}

-(BOOL)shouldAutorotate
{
    if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationMaskPortrait ) {
        return YES;
    }
    return YES;
}


- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}


@end
