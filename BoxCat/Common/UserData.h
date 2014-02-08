//
//  UserDefault.h
//  CHLogistics
//
//  Created by 杨 发兵 on 12-10-12.
//  Copyright (c) 2012年 Tianfu Software Park Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ManagerFile.h"
/**
 此单例用来保存一些程序设置，和全局变量
 **/


@interface UserData : NSObject
{
   
}

//标记是否第一次启动应用
@property (nonatomic ,assign) BOOL firstTag;

//当前关卡数
@property (nonatomic, assign) NSInteger currentLevel;

//总分数
@property (nonatomic, assign) NSInteger totalScore;

//当前关卡得分
@property (nonatomic ,assign) NSInteger currentScore;

//总金币数
@property (nonatomic, assign) NSInteger totalGold;

//每个关卡的得分
@property (nonatomic, strong) NSMutableDictionary *totalLevelScore;

//通过此方法调用单例，不要手动init
+ (UserData *)sharedUserData;

//保存版本数据
- (void)saveUserData;

//获取本关红色点位置数组
-(NSArray *)getRedDotsWithLevel:(NSInteger)level;

//获取本关最高历史记录
-(NSInteger)getCurrentBestScoreWithLevel:(NSInteger)level;

//保存本关最高得分
-(void)saveBestScore:(NSInteger)score withLevel:(NSInteger)level;

@end
