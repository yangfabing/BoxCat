//
//  Cat.m
//  BoxCat
//
//  Created by 杨 发兵 on 13-10-14.
//  Copyright (c) 2013年 yfb. All rights reserved.
//

#import "Cat.h"
#import "DotsScene.h"
@implementation Cat



-(id)initWithPosition:(CGPoint)vPosition
{
    if (self = [super initWithFrame:CGRectMake(0, 0, DOT_WIDTH, DOT_HEIGHT)]) {
        [self setImage:[UIImage imageNamed:@"cat.png"]];
        [self setFrame:CGRectMake(0, 0, DOT_WIDTH, DOT_HEIGHT)];
        self.xyPosition = vPosition;
    }

    return self;
}

-(void)walk
{
    
}


-(void)walkToPosition:(CGPoint)vposition
{
    self.xyPosition = vposition;
}


-(void)setPosition:(CGPoint)position
{
    [UIView animateWithDuration:0.1f animations:^{
        [self setAlpha:0];
    }completion:^(BOOL finish){
        [self setFrame:CGRectMake(position.x, position.y, self.frame.size.width, self.frame.size.height)];
        [UIView animateWithDuration:0.1f animations:^{
            [self setAlpha:1];
        }];

    }];
    
    
}

@end
