//
//  BasicViewController.h
//  biaoxuntong
//
//  Created by 杨 发兵 on 13-6-19.
//  Copyright (c) 2013年 杨 发兵. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BasicViewController : UIViewController

//自定义导航栏左按钮
-(void)addLeftBtnWithStr:(NSString *)str;

//自定义导航栏右按钮
-(void)addRightBtnWithStr:(NSString *)str;

@end
