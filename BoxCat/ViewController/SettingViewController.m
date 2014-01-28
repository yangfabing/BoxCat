//
//  SettingViewController.m
//  BoxCat
//
//  Created by 杨 发兵 on 14-1-16.
//  Copyright (c) 2014年 yfb. All rights reserved.
//

#import "SettingViewController.h"
#import "UMFeedback.h"

//自定义推荐界面
#import "RecommendViewController.h"
#import "UserData.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

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
    self.navigationController.navigationBarHidden = NO;

    self.title = @"更多";
    [self addLeftBtnWithStr:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
#pragma mark - UITableView Delegate

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier =@"moreCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        
    }
    
    NSInteger row = indexPath.row;
    switch (row) {
        case 0:
            cell.textLabel.text = @"意见反馈";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 1:
            cell.textLabel.text = @"给我们评价";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 2:
            cell.textLabel.text = @"我的其他应用";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 3:
        {
            cell.textLabel.text = @"当前版本";
            NSString *version = [[[NSBundle mainBundle] infoDictionary]valueForKey:@"CFBundleShortVersionString"];
            cell.detailTextLabel.text =[NSString stringWithFormat:@"version:%@",version];
            [cell.detailTextLabel setTextColor:[UIColor grayColor]];
        }
            break;
        default:
            break;
    }

    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [UMFeedback showFeedback:self withAppkey:UMENG_APPKEY];
            break;
        case 1:
            [self gotoStore];
            break;
        case 2:
            [self gotoRecommendView];
            break;
        case 3:
            break;
        default:
            break;
    }
}


-(void)gotoStore
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/cn/app/kuai-bo-lian-xi-ren-zhuo-mian/id705075672?mt=8"]]];
        
}

-(void)gotoRecommendView
{
    RecommendViewController *controller = [[RecommendViewController alloc] initWithNibName:@"RecommendViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}
@end
