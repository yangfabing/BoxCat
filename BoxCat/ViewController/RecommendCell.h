//
//  RecommendCell.h
//  ContactsIcon
//
//  Created by 杨 发兵 on 13-11-14.
//  Copyright (c) 2013年 yfb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *customImageView;
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *customDetailLabel;

@end
