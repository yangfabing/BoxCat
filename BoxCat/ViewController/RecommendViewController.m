//
//  RecommendViewController.m
//  ContactsIcon
//
//  Created by 杨 发兵 on 13-11-14.
//  Copyright (c) 2013年 yfb. All rights reserved.
//

#import "RecommendViewController.h"
#import "RecommendCell.h"
#import <QuartzCore/QuartzCore.h>

@interface RecommendViewController ()

@end

@implementation RecommendViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"我的其他应用", nil);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





#pragma mark - 
#pragma mark - UITableView Delegate


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indetifier = @"cell";
    RecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:indetifier];
    
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RecommendCell" owner:self options:nil] lastObject];
    }
    switch (indexPath.row) {
        case 1:
            [cell.customImageView setImage:[UIImage imageNamed:@"webdav.png"]];
            [cell.customImageView.layer setMasksToBounds:YES];
            [cell.customImageView.layer setCornerRadius:15];
            cell.name.text =  @"WebDAV助手";
            cell.customDetailLabel.text = @"WebDAV助手是您管理WebDAV服务器的最佳方式，通过她，您可以方便的管理WebDAV服务器文件和本地资源，无论是音乐，照片还是联系人，轻松搞定。";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 0:
            [cell.customImageView setImage:[UIImage imageNamed:@"kuaibo.png"]];
            [cell.customImageView.layer setMasksToBounds:YES];
            [cell.customImageView.layer setCornerRadius:15];
            cell.name.text =  @"快拨";
            cell.customDetailLabel.text = @"在你的iPhone桌面上创建联系人的快捷图标，点击图标即可拨打电话";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        default:
            break;
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row)
    {
        case 1:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/webdav-zhu-shou/id659323471?mt=8"]];
            break;
        case 0:
              [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/kuai-bo-lian-xi-ren-zhuo-mian/id705075672?mt=8"]];
            break;
        default:
            break;
    }
}
@end
