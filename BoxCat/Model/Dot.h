//
//  Dot.h
//  BoxCat
//
//  Created by 杨 发兵 on 13-10-14.
//  Copyright (c) 2013年 yfb. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface Dot : UIImageView


//标记dot是否被选中,选中后替换dot的图片
@property (nonatomic ,assign) BOOL isSelected;

//在二维数组中的位置
@property (nonatomic, assign) CGPoint xyPosition;

-(void)setDotPositionWithX:(int)x Y:(int)y;

-(id)initWithPosition:(CGPoint)vPosition;

-(void)dotTouched;


-(void)setPosition:(CGPoint)position;
@end
