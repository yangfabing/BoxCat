//
//  BasicViewController.m
//  biaoxuntong
//
//  Created by 杨 发兵 on 13-6-19.
//  Copyright (c) 2013年 杨 发兵. All rights reserved.
//

#import "BasicViewController.h"

@interface BasicViewController ()
{
}

@end

@implementation BasicViewController

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
        

    //设置导航栏背景图片
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbarImage.png"]
//                                                  forBarMetrics:UIBarMetricsDefault];
//    
    


}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//默认为返回上一级按钮，子类要实现其他功能需重写onLeftClick:方法
-(void)addLeftBtnWithStr:(NSString *)str
{
    

    self.navigationController.navigationBar.backItem.hidesBackButton= YES;
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [leftBtn setFrame:CGRectMake(20, 0, 24, 24)];
//    [leftBtn setTitle:str forState:UIControlStateNormal];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"btn_return_normal.png"] forState:UIControlStateNormal];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"btn_return_pressed.png"] forState:UIControlStateHighlighted];
    
    
    [leftBtn addTarget:self action:@selector(onLeftClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];

}


//默认为返回首页按钮，子类要实现其他功能需重写onRightClick:方法
-(void)addRightBtnWithStr:(NSString *)str
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [rightBtn setTitle:str forState:UIControlStateNormal];
    [rightBtn setFrame:CGRectMake(0, 0, 24, 24.0f)];
    [rightBtn setImage:[UIImage imageNamed:@"首页按钮_正常状态.png"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"首页按钮_按下状态.png"] forState:UIControlStateHighlighted];
    
    [rightBtn addTarget:self action:@selector(onRightClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];

    
}



-(void)onLeftClick:(id)sender
{
    if (![self.navigationController popViewControllerAnimated:YES]) {    
        [self.navigationController dismissViewControllerAnimated:YES completion:^{}];
    }
}

-(void)onRightClick:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{}];
}


@end
