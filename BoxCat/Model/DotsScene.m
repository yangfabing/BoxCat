//
//  MyScene.m
//  BoxCat
//
//  Created by 杨 发兵 on 13-10-14.
//  Copyright (c) 2013年 yfb. All rights reserved.
//

#import "DotsScene.h"
#import "Dot.h"
#import "Cat.h"

@interface DotsScene ()<UIAlertViewDelegate>
{
    
}

@end


@implementation DotsScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super init])
    {
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        [self setFrame:CGRectMake((screenSize.width - size.width)/2, (screenSize.height - size.height)/2, size.width, size.height)];
        [self setBackgroundColor:[UIColor whiteColor]];
        }
    return self;
}



-(void)installAllDotWithArray:(NSArray *)array
{
//    NSMutableArray *tempArray = [NSMutableArray array];
//    for (int i = 0; i < 5; i++)
//    {
//        CGPoint point = CGPointMake(arc4random()%DOT_X, arc4random()%DOT_Y);
//        if (point.x != floor(DOT_X/2) || point.y != floor(DOT_Y/2)) {
//            [tempArray addObject:[NSValue valueWithCGPoint:point]];
//        }
//    }
    [self createDotsWithSelectedDotsIndex:array];
    [self createCatWithPosition:CGPointMake(floor(DOT_X/2), floor(DOT_Y/2))];

}

#pragma mark -
#pragma mark - UITouch  Methods

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches)
    {
        CGPoint location = [touch locationInView:self];
//        NSLog(@"location:%@",NSStringFromCGPoint(location));
        
        for (NSArray *tempArray in self.dotsArray)
        {
            for (Dot *dot in tempArray)
            {
                if (CGRectContainsPoint(dot.frame, location))
                {
//                    NSLog(@"touched %@",NSStringFromCGPoint(dot.xyPosition));
                    //如果dot未被选中过
                    if (!dot.isSelected && !CGPointEqualToPoint(dot.xyPosition, self.cat.xyPosition))
                    {
                        [dot dotTouched];
                        if (self.delegate && [self.delegate respondsToSelector:@selector(didTouchDot)])
                        {
                            [self.delegate didTouchDot];
                        }
                        
                        [self walk];

                    }
                }
            }
        }
    }
}

-(void)update:(CFTimeInterval)currentTime
{
    
    
    
}




#pragma mark - 
#pragma  mark - Custom Methods


//创建cat
-(void)createCatWithPosition:(CGPoint)position
{
    self.cat = [[Cat alloc] initWithPosition:position];
    if (((int)position.y)%2 == 0)
    {
        [self.cat setPosition:CGPointMake(position.x*(DOT_WIDTH+DOT_DOT_WIDTH/2) +LEFT_WIDTH, position.y*(DOT_HEIGHT+DOT_DOT_WIDTH/2) + BOTTOM_HEGHT)];

    }else
    {
        [self.cat setPosition:CGPointMake(position.x*(DOT_WIDTH+DOT_DOT_WIDTH/2) +LEFT_WIDTH + DOT_WIDTH/2, position.y*(DOT_HEIGHT+DOT_DOT_WIDTH/2) + BOTTOM_HEGHT)];

    }
    [self addSubview:self.cat];
}


//移动cat,改变cat的position
-(void)moveCatToPosition:(CGPoint)position
{
    if (((int)position.y)%2 == 0)
    {
        [self.cat setPosition:CGPointMake(position.x*(DOT_WIDTH+DOT_DOT_WIDTH/2) +LEFT_WIDTH, position.y*(DOT_HEIGHT+DOT_DOT_WIDTH/2) + BOTTOM_HEGHT)];
        
    }else
    {
        [self.cat setPosition:CGPointMake(position.x*(DOT_WIDTH+DOT_DOT_WIDTH/2) +LEFT_WIDTH + DOT_WIDTH/2, position.y*(DOT_HEIGHT+DOT_DOT_WIDTH/2) + BOTTOM_HEGHT)];
        
    }
    //行走动画
    [self.cat walkToPosition:position];

}

//创建dot
-(void)createDotsWithSelectedDotsIndex:(NSArray *)selectedDots
{
    self.dotsArray = [NSMutableArray arrayWithCapacity:DOT_Y];
    for (int y = 0; y< DOT_Y; y++)
    {
        NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:DOT_X];
        for (int x = 0; x < DOT_X; x++)
        {
            Dot *dot = [[Dot alloc] initWithPosition:CGPointMake(x, y)];
            [dot setDotPositionWithX:x Y:y];
            if (y%2 == 0)
            {
                [dot setPosition:CGPointMake(x*(DOT_WIDTH + DOT_DOT_WIDTH/2) + LEFT_WIDTH , y*(DOT_HEIGHT+DOT_DOT_WIDTH/2) + BOTTOM_HEGHT)];
            }else
            {
                [dot setPosition:CGPointMake(x*(DOT_WIDTH + DOT_DOT_WIDTH/2) + LEFT_WIDTH + DOT_WIDTH/2 , y*(DOT_HEIGHT + DOT_DOT_WIDTH/2) + BOTTOM_HEGHT)];

            }
            [self addSubview:dot];
            [tempArray addObject:dot];
        }
        
        [self.dotsArray addObject:tempArray];
    }
    
    
    
    for (id obj in selectedDots)
    {
        CGPoint position = [obj CGPointValue];
        Dot *tempDot = [self getDotsWithPosition:position];
        [tempDot dotTouched];
    }
    
}


//获得某一个dot
-(Dot *)getDotsWithPosition:(CGPoint)position
{
    return [[self.dotsArray objectAtIndex:position.y] objectAtIndex:position.x];
}



//移动cat
-(void)walk
{
    //当前点搜索的结果保存,point.x 表示到边界的步数，point.y表示方向
    CGPoint tempPoint0;
    //模拟当前点左边点到边界的结果，point.x 表示到边界的步数，point.y表示方向（0，1，2，3，4，5）
    CGPoint tempPoint1;
    //模拟当前点左上点到边界的结果，point.x 表示到边界的步数，point.y表示方向
    CGPoint tempPoint2;
    //模拟当前点右上点到边界的结果，point.x 表示到边界的步数，point.y表示方向
    CGPoint tempPoint3;
    //模拟当前点右边点到边界的结果，point.x 表示到边界的步数，point.y表示方向
    CGPoint tempPoint4;
    //模拟当前点右下点到边界的结果，point.x 表示到边界的步数，point.y表示方向
    CGPoint tempPoint5;
    //模拟当前点左下点到边界的结果，point.x 表示到边界的步数，point.y表示方向
    CGPoint tempPoint6;
    
    //最终结果，point.x 表示到边界的步数，point.y表示方向
    CGPoint resultPoint = CGPointMake(-1, -1);

    //先从当前点实际位置开始搜索
    tempPoint0 = [self searchFormNearDotsWithCurrentPoint:self.cat.xyPosition];
    resultPoint = tempPoint0;
    
    
    //如果每个直达方向都被堵的话或者直达方向的距离太远的话，就从附近重新开始搜索
    if (tempPoint0.x > DOT_X/2) {
        //模拟当前点为左边点
        tempPoint1 = [self searchFormNearDotsWithCurrentPoint:CGPointMake(self.cat.xyPosition.x - 1, self.cat.xyPosition.y)];
        
        //左上
        if (((int)self.cat.xyPosition.y)%2 != 0) {
             tempPoint2 = [self searchFormNearDotsWithCurrentPoint:CGPointMake(self.cat.xyPosition.x, self.cat.xyPosition.y -1)];
        }else
        {
             tempPoint2 = [self searchFormNearDotsWithCurrentPoint:CGPointMake(self.cat.xyPosition.x - 1, self.cat.xyPosition.y - 1)];
        }
        
        //右上
        if (((int)self.cat.xyPosition.y)%2 != 0) {
            tempPoint3 = [self searchFormNearDotsWithCurrentPoint:CGPointMake(self.cat.xyPosition.x + 1, self.cat.xyPosition.y - 1)];
        }else
        {
            tempPoint3 = [self searchFormNearDotsWithCurrentPoint:CGPointMake(self.cat.xyPosition.x, self.cat.xyPosition.y - 1)];
        }
        
        //模拟当前点为右边点
        tempPoint4 = [self searchFormNearDotsWithCurrentPoint:CGPointMake(self.cat.xyPosition.x + 1, self.cat.xyPosition.y)];

        //右下
        if (((int)self.cat.xyPosition.y)%2 != 0) {
            tempPoint5 = [self searchFormNearDotsWithCurrentPoint:CGPointMake(self.cat.xyPosition.x + 1, self.cat.xyPosition.y + 1)];
        }else
        {
            tempPoint5 = [self searchFormNearDotsWithCurrentPoint:CGPointMake(self.cat.xyPosition.x, self.cat.xyPosition.y + 1)];
        }
        
        //左下
        if (((int)self.cat.xyPosition.y)%2 != 0) {
            tempPoint6 = [self searchFormNearDotsWithCurrentPoint:CGPointMake(self.cat.xyPosition.x , self.cat.xyPosition.y + 1)];
        }else
        {
            tempPoint6 = [self searchFormNearDotsWithCurrentPoint:CGPointMake(self.cat.xyPosition.x -1, self.cat.xyPosition.y + 1)];
        }
        
        //开始排序，找到最近距离
        CGPoint finalPoint   = tempPoint1;
        resultPoint = CGPointMake(tempPoint1.x, 0);
        if (tempPoint2.x <= finalPoint.x)
        {
            finalPoint = tempPoint2;
            resultPoint = CGPointMake(tempPoint2.x, 1);
        }
        if (tempPoint3.x <= finalPoint.x)
        {
            finalPoint = tempPoint3;
            resultPoint = CGPointMake(tempPoint3.x, 2);

        }
        if (tempPoint4.x <= finalPoint.x)
        {
            finalPoint = tempPoint4;
            resultPoint = CGPointMake(tempPoint4.x, 3);

        }
        if (tempPoint5.x <= finalPoint.x)
        {
            finalPoint = tempPoint5;
            resultPoint = CGPointMake(tempPoint5.x, 4);

        }
        if (tempPoint6.x <= finalPoint.x)
        {
            finalPoint = tempPoint6;
            resultPoint = CGPointMake(tempPoint6.x, 5);
        }
        
        if (resultPoint.x + 1 >= tempPoint0.x)
        {
            resultPoint = tempPoint0;
        }
    }

//    NSLog(@"orientation:%.1f, temp:%.1f",resultPoint.y, resultPoint.x);
    
    //胜利
    if (resultPoint.x == 100)
    {
        [self gameSuccess];
        return;
    }
    
    //失败
//        NSLog(@"cat position:%@",NSStringFromCGPoint(self.cat.xyPosition));
        if (self.cat.xyPosition.x <= 0 || self.cat.xyPosition.x >= DOT_X -1 || self.cat.xyPosition.y <= 0 || self.cat.xyPosition.y >= DOT_Y -1) {
          
            [self gameFailed];
            return;
        }
       
    
    //游戏未结束，开始移动当前点
    int orientation = (int)resultPoint.y;
    switch (orientation)
{
        case 0://左边
        [self moveCatToPosition:CGPointMake(self.cat.xyPosition.x - 1,self.cat.xyPosition.y)];
            break;
        case 1://左上
        if (((int)self.cat.xyPosition.y + 1)%2 != 0)
        {
            [self moveCatToPosition:CGPointMake(self.cat.xyPosition.x - 1,self.cat.xyPosition.y - 1)];

        }else
        {
            [self moveCatToPosition:CGPointMake(self.cat.xyPosition.x,self.cat.xyPosition.y - 1)];
        }
            break;
        case 2://右上
        if (((int)self.cat.xyPosition.y + 1)%2 == 0)
        {
            [self moveCatToPosition:CGPointMake(self.cat.xyPosition.x + 1,self.cat.xyPosition.y - 1)];
            
        }else
        {
            [self moveCatToPosition:CGPointMake(self.cat.xyPosition.x,self.cat.xyPosition.y - 1)];
        }

            break;
        case 3://右边
        [self moveCatToPosition:CGPointMake(self.cat.xyPosition.x + 1,self.cat.xyPosition.y)];
            break;
        case 4://右下
        if (((int)self.cat.xyPosition.y + 1)%2 == 0)
        {
            [self moveCatToPosition:CGPointMake(self.cat.xyPosition.x + 1,self.cat.xyPosition.y + 1)];
            
        }else
        {
            [self moveCatToPosition:CGPointMake(self.cat.xyPosition.x,self.cat.xyPosition.y + 1)];
        }

            break;
        case 5://左下
        if (((int)self.cat.xyPosition.y + 1)%2 != 0)
        {
            [self moveCatToPosition:CGPointMake(self.cat.xyPosition.x - 1,self.cat.xyPosition.y + 1)];
            
        }else
        {
            [self moveCatToPosition:CGPointMake(self.cat.xyPosition.x,self.cat.xyPosition.y + 1)];
        }

            break;
        default:
            break;
    }
    
    
    
    //移动完成后在判断一下
//    NSLog(@"cat position:%@",NSStringFromCGPoint(self.cat.xyPosition));
    if (self.cat.xyPosition.x <= 0 || self.cat.xyPosition.x >= DOT_X -1 || self.cat.xyPosition.y <= 0 || self.cat.xyPosition.y >= DOT_Y -1) {
        
        [self gameFailed];
        return;
    }
    
    
}


-(CGPoint)searchFormNearDotsWithCurrentPoint:(CGPoint) point
{
    //先判断该点是否已经被选中，如果被选中的话就直接返回
    Dot *tempDot = [self getDotsWithPosition:point];
    if (tempDot.isSelected || !tempDot) {
        return CGPointMake(1000, 1000);
    }
    //6个方向到被堵住的步数
    int leftNum = 100;
    int leftbottomNum = 100;
    int lefttopNum = 100;
    int rightNum = 100;
    int rightopNum = 100;
    int rightbottomNum = 100;
    
    //6个方向到边界的步数
    int left_boxNum = 0;
    int leftTop_boxNum = 0;
    int rightTop_boxNum = 0;
    int right_boxNum = 0;
    int rightBottom_boxNum = 0;
    int leftBottom_boxNum = 0;
    
//    NSLog(@"==========================================");
    CGPoint catPosition = point;
//    NSLog(@"模拟当前点为：%@",NSStringFromCGPoint(catPosition));
    BOOL isBOX = NO;
    //先从cat所在行开始遍历
    int stepNum = 0;
    //左边
    for (int i = catPosition.x - 1; i >=0; i--)
    {
        Dot *dot = [self getDotsWithPosition:CGPointMake(i, catPosition.y)];
        if (dot.isSelected)
        {
            isBOX = YES;
//            NSLog(@"左边路被堵");
            break;
        }else
        {
            stepNum ++;
        }
    }
    if (isBOX)
    {
        left_boxNum = stepNum;
//        NSLog(@"离左边被堵点步数:%d",stepNum);
    }else
    {
        leftNum = stepNum;
//        NSLog(@"到左边边界步数:%d",stepNum);
        
    }
    //右边
    stepNum = 0;
    isBOX = NO;
    for (int i = catPosition.x + 1; i < DOT_X; i++)
    {
        Dot *dot = [self getDotsWithPosition:CGPointMake(i, catPosition.y)];
        if (dot.isSelected)
        {
            isBOX = YES;
//            NSLog(@"右边路被堵");
            break;
        }else
        {
            stepNum ++;
        }
    }
    
    if (isBOX)
    {
        right_boxNum = stepNum;
//        NSLog(@"离右边被堵点步数:%d",stepNum);
    }else
    {
        rightNum = stepNum;
//        NSLog(@"到右边边界步数:%d",stepNum);
        
    }
    
    
    //左上
    stepNum = 0;
    isBOX = NO;
    int tempx = catPosition.x;
    for (int i = catPosition.y - 1; i >=0; i--)
    {
        if (i%2 != 0)
        {
            tempx --;
        }
        
        if (tempx < 0)
        {
            break;
        }
        Dot *dot = [self getDotsWithPosition:CGPointMake(tempx, i)];
        if (dot.isSelected)
        {
            isBOX = YES;
//            NSLog(@"左上路被堵");
            break;
        }else
        {
            stepNum ++;
        }
        
    }
    
    if (isBOX)
    {
        leftTop_boxNum = stepNum;
//        NSLog(@"离左上被堵点步数:%d",stepNum);
    }else
    {
        lefttopNum = stepNum;
//        NSLog(@"到左上边界步数:%d",stepNum);
        
    }
    
    
    
    
    
    //右上
    stepNum = 0;
    isBOX = NO;
    tempx = catPosition.x;
    for (int i = catPosition.y - 1; i >=0; i--)
    {
        if (i%2 == 0)
        {
            tempx ++;
        }
        
        if (tempx >= DOT_X)
        {
            break;
        }
        Dot *dot = [self getDotsWithPosition:CGPointMake(tempx, i)];
        if (dot.isSelected)
        {
            isBOX = YES;
//            NSLog(@"右上路被堵");
            break;
        }else
        {
            stepNum ++;
        }
        
    }
    
    if (isBOX)
    {
        rightTop_boxNum = stepNum;
//        NSLog(@"离右上被堵点步数:%d",stepNum);
    }else
    {
        rightopNum = stepNum;
//        NSLog(@"到右上边界步数:%d",stepNum);
        
    }

    
    stepNum = 0;
    isBOX = NO;
    //左下
     tempx = catPosition.x;
    for (int i = catPosition.y + 1; i <DOT_Y; i++)
    {
        if (i%2 != 0)
        {
            tempx --;
        }
        
        if (tempx < 0)
        {
            break;
        }
        Dot *dot = [self getDotsWithPosition:CGPointMake(tempx, i)];
        if (dot.isSelected)
        {
            isBOX = YES;
//            NSLog(@"左下路被堵");
            break;
        }else
        {
            stepNum ++;
        }
        
    }
    
    if (isBOX)
    {
        leftBottom_boxNum = stepNum;
//        NSLog(@"离左下被堵点步数:%d",stepNum);
    }else
    {
        leftbottomNum = stepNum;
//        NSLog(@"到左下边界步数:%d",stepNum);
        
    }
    
    
    
    //右下
    stepNum = 0;
    isBOX = NO;
    tempx = catPosition.x;
    for (int i = catPosition.y + 1; i <DOT_Y; i++)
    {
        if (i%2 == 0)
        {
            tempx ++;
        }
        
        if (tempx >= DOT_X)
        {
            break;
        }
        Dot *dot = [self getDotsWithPosition:CGPointMake(tempx, i)];
        if (dot.isSelected)
        {
            isBOX = YES;
//            NSLog(@"右下路被堵");
            
            break;
        }else
        {
            stepNum ++;
        }
        
    }
    
    if (isBOX)
    {
        rightBottom_boxNum = stepNum;
//        NSLog(@"离右下被堵点步数:%d",stepNum);
    }else
    {
        rightbottomNum = stepNum;
//        NSLog(@"到右下边界步数:%d",stepNum);
        
    }
    
    
    //遍历完成后获得所有路径的步数
    //开始移动cat
    int orientation = 0;
    int temp = leftNum;
    if (lefttopNum <= temp)
    {
        temp = lefttopNum;
        orientation = 1;
    }
    
    if (rightopNum <= temp)
    {
        temp = rightopNum;
        orientation =2;
    }
    
    if (rightNum <= temp)
    {
        temp = rightNum;
        orientation = 3;
    }
  
    if (rightbottomNum <= temp)
    {
        temp = rightbottomNum;
        orientation = 4;
    }
    if (leftbottomNum <= temp)
    {
        temp = leftbottomNum;
        orientation = 5;
    }
        
    return CGPointMake(temp, orientation);
}

-(void)refreshDotsAndCat
{
    for (int y = 0; y < DOT_Y; y++)
    {
        for (int x = 0; x < DOT_Y; x++)
        {
            Dot *dot = [self getDotsWithPosition:CGPointMake(x, y)];
            if (dot)
            {
                [dot removeFromSuperview];
            }
        }
    }
    [self.dotsArray removeAllObjects];
    
    [self.cat removeFromSuperview];
    self.cat = nil;
    
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < 5; i++)
    {
        CGPoint point = CGPointMake(arc4random()%DOT_X, arc4random()%DOT_Y);
        if (point.x != floor(DOT_X/2) || point.y != floor(DOT_Y/2)) {
            [tempArray addObject:[NSValue valueWithCGPoint:point]];
        }
    }
    [self createDotsWithSelectedDotsIndex:tempArray];
    [self createCatWithPosition:CGPointMake(floor(DOT_X/2), floor(DOT_X/2))];
}



#pragma  mark -
#pragma mark - UIAlertView Delegate


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != alertView.cancelButtonIndex)
    {
        [self refreshDotsAndCat];
    }else
    {
    }
}




-(void)gameSuccess
{
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"好样的" message:@"你赢了！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"再来一次", nil];
//    [alert show];
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSuccessed)])
    {
        [self.delegate didSuccessed];
    }
    return;
}


-(void)gameFailed
{
//    NSLog(@"game over");
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"加油！" message:@"你输了！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"再来一次", nil];
//    [alert show];
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didFailed)])
    {
        [self.delegate didFailed];
    }
}
@end
