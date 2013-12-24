//
//  ManagerFile.m
//  ChenShiTaiJi
//
//  Created by 杨 发兵 on 13-10-11.
//  Copyright (c) 2013年 yfb. All rights reserved.
//

#import "ManagerFile.h"

@implementation ManagerFile



+(void)writeFile:(NSString *)file
{
    //创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //获取路径
    //参数NSDocumentDirectory要获取那种路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];//去处需要的路径
    //定义记录文件全名以及路径的字符串filePath
    
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"note.txt"];
    
    //查找文件，如果不存在，就创建一个文件
    
    if (![fileManager fileExistsAtPath:filePath]) {
        
        [fileManager createFileAtPath:filePath contents:nil attributes:nil];
        
    }
    
    //创建数据缓冲
    NSMutableData *writer = [[NSMutableData alloc] init];
    //将字符串添加到缓冲中
    [writer appendData:[file dataUsingEncoding:NSUTF8StringEncoding]];
    //将其他数据添加到缓冲中
    //将缓冲的数据写入到文件中
    [writer writeToFile:filePath atomically:YES];
}



+(NSString *)readFileWithLevel:(NSInteger)level
{
    //创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //获取路径
    //参数NSDocumentDirectory要获取那种路径
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];//去处需要的路径
//    
//    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"level_%d.txt",level]];
//    
   NSString *filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"level_%d",level] ofType:@"txt"];
    
    //查找文件，如果不存在，就创建一个文件
    if (![fileManager fileExistsAtPath:filePath]) {
        
//        [fileManager createFileAtPath:filePath contents:nil attributes:nil];
        
        return nil;
    }
    
    NSData *reader = [NSData dataWithContentsOfFile:filePath];
    return [[NSString alloc] initWithData:reader  encoding:NSUTF8StringEncoding];
}
@end
