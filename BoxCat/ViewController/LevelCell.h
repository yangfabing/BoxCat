//
//  LevelCell.h
//  BoxCat
//
//  Created by 杨 发兵 on 14-1-26.
//  Copyright (c) 2014年 yfb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LevelCell : UIView

@property (weak, nonatomic) IBOutlet UILabel *levelLable;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *levelBtn;

@end
