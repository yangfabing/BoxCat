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

#import "GADBannerView.h"
#import "GADRequest.h"
#import "DoAlertView.h"

#import "MCSoundBoard.h"

@interface GameViewController ()<DotsResultDelegate, GADBannerViewDelegate>
{
    GADBannerView *admobView;
    
    NSInteger redDotsCount;
    NSInteger currentScore;
    NSArray *redArray;
    
    DoAlertView *doAlertView;
    
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
    [self loadADView];
    BOOL tag = [UserData sharedUserData].firstTag;
    if (!tag) {
        [self showFristAlertView];
        [UserData sharedUserData].firstTag = YES;
        [[UserData sharedUserData] saveUserData];
    }
    [self restartGameWithCurrentLevel:self.currentLevel];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
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
    controller.gameController = self;
    [self.navigationController pushViewController:controller animated:YES];
    
}


#pragma mark - 
#pragma mark - Custom Methods

//通过关卡初始化
-(void)restartGameWithCurrentLevel:(NSInteger)level
{
//    NSLog(@"level:%d",level);
    self.levelLabel.text = [NSString stringWithFormat:@"%d",level];
    
    if (self.scene)
    {
        [self.scene removeFromSuperview];
        self.scene.delegate = nil;
    }
    
    self.scene = [[DotsScene alloc] initWithSize:CGSizeMake(320, 320)];
    redArray = [[UserData sharedUserData] getRedDotsWithLevel:level];
    if (redArray.count == 0) {
       NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < 5; i++)
        {
            CGPoint point = CGPointMake(arc4random()%DOT_X, arc4random()%DOT_Y);
            if (point.x != floor(DOT_X/2) || point.y != floor(DOT_Y/2)) {
                [array addObject:[NSValue valueWithCGPoint:point]];
            }
        }
        redArray = array;
    }
//    redDotsCount = redArray.count;
    redDotsCount = 0;

    [_scene installAllDotWithArray:redArray];
    _scene.delegate = self;
    [self.view addSubview:_scene];
    
    [self refreshScore];
}

//重新开始
-(void)playAgain
{
    if (self.scene)
    {
        [self.scene removeFromSuperview];
        self.scene.delegate = nil;
    }
    self.scene = [[DotsScene alloc] initWithSize:CGSizeMake(320, 320)];
    
    redDotsCount = 0;
    
    [_scene installAllDotWithArray:redArray];
    _scene.delegate = self;
    [self.view addSubview:_scene];
    
    [self refreshScore];

}


//刷新分数
-(void)refreshScore
{
    currentScore = (100 - redDotsCount);
    self.scoreLabel.text = [NSString stringWithFormat:@"%d",currentScore];
    [self randomRefreshGold];
}


//随机给予用户金币
-(void)randomRefreshGold
{
//    NSInteger rand = arc4random()%10;
//    if (rand == 1) {
//        [UserData sharedUserData].totalGold += 5;
//    }
//    
//    [self.goldLabel setText:[NSString stringWithFormat:@"%d",[UserData sharedUserData].totalGold]];
}

#pragma mark - 
#pragma mark - DotsResultDelegate Methods

-(void)didTouchDot
{
    redDotsCount++;
    [MCSoundBoard playSoundForKey:@"touchSound"];
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


#pragma mark - 
#pragma mark - show AlertView

-(void)showFristAlertView
{
    doAlertView = [[DoAlertView alloc] init];
    doAlertView.nAnimationType = DoTransitionStyleLine;
    doAlertView.dRound = 2.0;
    
    [doAlertView doAlert:nil body:@"点击“绿色”圆点来围住“蓝色”圆点,让它无路可逃~~~" duration:0 done:^(DoAlertView *alertView) {
//        NSLog(@"showed");
    }];
    
    
[NSTimer scheduledTimerWithTimeInterval:8.0 target:self selector:@selector(hideAlertView) userInfo:nil repeats:NO];
}

-(void)hideAlertView
{
    [doAlertView hideAlert];
}

#pragma  mark - 
#pragma mark - AD Delegate

-(void)loadADView
{
    
    
    if (!SHOW_ADVIEW) {
        return;
    }
    
    // 在屏幕底部创建标准尺寸的视图。
    admobView = [[GADBannerView alloc]
                 initWithFrame:CGRectMake(0.0,
                                          self.view.frame.size.height -
                                          GAD_SIZE_320x50.height,
                                          GAD_SIZE_320x50.width,
                                          GAD_SIZE_320x50.height)];
    
    // 指定广告的“单元标识符”，也就是您的 AdMob 发布商 ID。
    admobView.adUnitID = MY_BANNER_UNIT_ID;
    
    admobView.delegate = self;
    
    // 告知运行时文件，在将用户转至广告的展示位置之后恢复哪个 UIViewController
    // 并将其添加至视图层级结构。
    admobView.rootViewController = self;
    [self.view addSubview:admobView];
    
    // 启动一般性请求并在其中加载广告。
    [admobView loadRequest:[GADRequest request]];
//    [admobView loadRequest:[self createRequest]];
    
}

-(void)hideADView{
    if (admobView)
    {
        [admobView removeFromSuperview];
    }
}


#pragma mark GADRequest generation

// Here we're creating a simple GADRequest and whitelisting the simulator
// and two devices for test ads. You should request test ads during development
// to avoid generating invalid impressions and clicks.
- (GADRequest *)createRequest {
    GADRequest *request = [GADRequest request];
    
    //Make the request for a test ad
    request.testDevices = [NSArray arrayWithObjects:
                           GAD_SIMULATOR_ID,                               // Simulator
                           nil];
    
    return request;
}



#pragma mark GADBannerViewDelegate impl

// Since we've received an ad, let's go ahead and set the frame to display it.
- (void)adViewDidReceiveAd:(GADBannerView *)adView {
    //    NSLog(@"Received ad");
    
    [UIView animateWithDuration:0.5 animations:^ {
        adView.frame = CGRectMake(0.0,
                                  self.view.frame.size.height -
                                  adView.frame.size.height,
                                  adView.frame.size.width,
                                  adView.frame.size.height);
        
    }];
}

- (void)adView:(GADBannerView *)view
didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"Failed to receive ad with error: %@", [error localizedFailureReason]);
}





@end
