//
//  ZAccountSecurityViewController.m
//  youqinghai
//
//  Created by snailz on 16/3/30.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "ZAccountSecurityViewController.h"
#import "UIViewController+TableView.h"
#import "ZModifyPhoneViewController.h"
#import "ZModifyPassWordViewController.h"
@interface ZAccountSecurityViewController ()

@end

@implementation ZAccountSecurityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账户安全";
    self.view.backgroundColor = spaceColor238238238();
    self.tableView.backgroundColor = [UIColor clearColor];

    // Do any additional setup after loading the view.
}
#pragma mark -delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

{
    
    return 2;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    // 下面这几行代码是用来设置cell的上下行线的位置
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 20, 0, 20)];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell   *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[ UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.textLabel.textColor = [UIColor colorWithRed:0.286 green:0.286 blue:0.298 alpha:1.000];
        cell.detailTextLabel.textColor = [UIColor colorWithRed:0.286 green:0.286 blue:0.298 alpha:1.000];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    }
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"手机验证";
            cell.detailTextLabel.text = [[ZUserModel shareUserModel].phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
            break;
        case 1:
            cell.textLabel.text = @"登录密码";
            break;
        default:
            break;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            ZModifyPhoneViewController *mpv = [[ZModifyPhoneViewController alloc]init];
            [self.navigationController pushViewController:mpv animated:YES];
        }
            break;
        case 1:
        {
            ZModifyPassWordViewController *mpv = [[ZModifyPassWordViewController alloc]init];
            [self.navigationController pushViewController:mpv animated:YES];
        }
            break;
        default:
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
    return  44;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
