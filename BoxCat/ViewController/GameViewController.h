//
//  ViewController.h
//  BoxCat
//

//  Copyright (c) 2013年 yfb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIButton *scoreButton;
@property (weak, nonatomic) IBOutlet UIButton *goldBtn;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *goldLabel;


- (IBAction)onPauseClick:(id)sender;

//开始游戏。初始化关卡
-(void)restartGameWithCurrentLevel:(NSInteger)level;
@end
