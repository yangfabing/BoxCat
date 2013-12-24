//
//  Dot.m
//  BoxCat
//
//  Created by 杨 发兵 on 13-10-14.
//  Copyright (c) 2013年 yfb. All rights reserved.
//

#import "Dot.h"
#import "DotsScene.h"

@implementation Dot

-(id)initWithPosition:(CGPoint)vPosition
{
    if (self = [super initWithFrame:CGRectMake(0, 0, DOT_WIDTH, DOT_HEIGHT)]) {
        [self setImage:[UIImage imageNamed:@"dot.png"]];
        [self setFrame:CGRectMake(0, 0, DOT_WIDTH, DOT_HEIGHT)];
        self.xyPosition = vPosition;
    }
    
    return self;
}


-(void)setDotPositionWithX:(int)x Y:(int)y
{
    self.xyPosition = CGPointMake(x, y);
}


-(void)dotTouched
{
    self.isSelected = YES;
    [self setImage:[UIImage imageNamed:@"dot_selected.png"]];
}



-(void)setPosition:(CGPoint)position
{
    [self setFrame:CGRectMake(floor(DOT_X/2) * (DOT_WIDTH + DOT_DOT_WIDTH/2) + LEFT_WIDTH , floor(DOT_X/2) *(DOT_HEIGHT+DOT_DOT_WIDTH/2) + BOTTOM_HEGHT, self.frame.size.width, self.frame.size.height)];
    [UIView animateWithDuration:0.5f animations:^{
        [self setFrame:CGRectMake(position.x, position.y, self.frame.size.width, self.frame.size.height)];

    }];
}

@end
