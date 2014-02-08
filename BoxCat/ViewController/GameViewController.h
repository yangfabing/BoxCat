//
//  ViewController.h
//  BoxCat
//

//  Copyright (c) 2013年 yfb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameViewController : UIViewController

@property (nonatomic ,assign) NSInteger currentLevel;

@property (weak, nonatomic) IBOutlet UIButton *scoreButton;
@property (weak, nonatomic) IBOutlet UIButton *goldBtn;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *goldLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;


- (IBAction)onPauseClick:(id)sender;

//开始游戏。初始化关卡
-(void)restartGameWithCurrentLevel:(NSInteger)level;
-(void)playAgain;

@end
