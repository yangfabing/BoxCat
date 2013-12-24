//
//  Cat.h
//  BoxCat
//
//  Created by 杨 发兵 on 13-10-14.
//  Copyright (c) 2013年 yfb. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface Cat : UIImageView


@property (nonatomic, assign) CGPoint xyPosition;


-(void)walkToPosition:(CGPoint)vposition;
-(void)walk;
-(id)initWithPosition:(CGPoint)vPosition;

-(void)setPosition:(CGPoint)position;

@end
