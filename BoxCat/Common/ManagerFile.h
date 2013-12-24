//
//  ManagerFile.h
//  ChenShiTaiJi
//
//  Created by 杨 发兵 on 13-10-11.
//  Copyright (c) 2013年 yfb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ManagerFile : NSObject


+(void)writeFile:(NSString *)file;
+(NSString *)readFileWithLevel:(NSInteger)level;
@end
