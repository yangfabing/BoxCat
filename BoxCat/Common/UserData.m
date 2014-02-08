//
//  UserDefault.m
//  CHLogistics
//
//  Created by 杨 发兵 on 12-10-12.
//  Copyright (c) 2012年 Tianfu Software Park Co., Ltd. All rights reserved.
//

#import "UserData.h"

@implementation UserData

static UserData *sharedData;

+ (UserData *)sharedUserData
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedData = [[UserData alloc]init];
    });
    return sharedData;
}

-(id)init
{
    self = [super init];
    if (self != nil) {
        [self getUserData];
        }
    
    return self;
}




//获取NSUserDefaults数据
-(void) getUserData
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    self.totalGold = [defaults integerForKey:@"TotalGold"];
    self.totalScore = [defaults integerForKey:@"TotalScore"];
    self.currentLevel = [defaults integerForKey:@"CurrentLevel"];
    self.totalLevelScore = [defaults valueForKey:@"TotalLevelScore"];
    self.firstTag = [defaults boolForKey:@"firstTag"];
}

//保存NSUserDefaults数据
-(void)saveUserData
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:self.totalGold forKey:@"TotalGold"];
    [defaults setInteger:self.totalScore forKey:@"TotalScore"];
    [defaults setInteger:self.currentLevel forKey:@"CurrentLevel"];
    [defaults setValue:self.totalLevelScore forKey:@"TotalLevelScore"];
    [defaults setBool:self.firstTag forKey:@"firstTag"];
    [defaults synchronize];
}




-(NSArray *)getRedDotsWithLevel:(NSInteger)level
{
    NSString *str = [ManagerFile readFileWithLevel:level];
    if (!str)
    {
        return nil;
    }
    NSMutableArray *resultArray = [NSMutableArray array];
    
    NSArray *tempArray = [str componentsSeparatedByString:@","];
    for (NSString *tempStr in tempArray)
    {
        NSArray *dotPosition = [tempStr componentsSeparatedByString:@"."];
        CGPoint position = CGPointMake([[dotPosition objectAtIndex:0] integerValue], [[dotPosition objectAtIndex:1] integerValue]);
        
        [resultArray addObject:[NSValue valueWithCGPoint:position]];
    }
    
    
    
    return resultArray;
}



-(NSInteger)getCurrentBestScoreWithLevel:(NSInteger)level
{
    if (!self.totalLevelScore)
    {
        self.totalLevelScore = [NSMutableDictionary dictionary];
        return 0;
    }
    
    NSInteger bestScore = [[self.totalLevelScore valueForKey:[NSString stringWithFormat:@"%d",level]] integerValue];
    
    return bestScore;
}


-(void)saveBestScore:(NSInteger)score withLevel:(NSInteger)level
{
    [self.totalLevelScore setValue:[NSNumber numberWithInt:score] forKey:[NSString stringWithFormat:@"%d",level]];
    [self saveUserData];
}



@end
