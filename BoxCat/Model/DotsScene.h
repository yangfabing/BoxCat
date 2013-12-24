//
//  MyScene.h
//  BoxCat
//

//  Copyright (c) 2013年 yfb. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Dot;
@class Cat;

//点的横竖个数
#define DOT_X   9
#define DOT_Y   9

//点的宽高度
#define DOT_WIDTH 25
#define DOT_HEIGHT 25

//2点之间的间距
#define DOT_DOT_WIDTH 6



#define LEFT_WIDTH    25
#define BOTTOM_HEGHT  30

@protocol DotsResultDelegate <NSObject>


-(void)didTouchDot;
-(void)didSuccessed;
-(void)didFailed;

@end

@interface DotsScene : UIView


-(id)initWithSize:(CGSize)size;
@property (nonatomic, strong) NSMutableArray *dotsArray;

@property (nonatomic, strong) Cat *cat;

@property (nonatomic, assign) id<DotsResultDelegate>delegate;


-(void)createDotsWithSelectedDotsIndex:(NSArray *)selectedDots;

-(void)createCatWithPosition:(CGPoint) position;


@property(nonatomic, strong) NSMutableArray *stepNumArray;

-(void)installAllDotWithArray:(NSArray *)array;

@end
