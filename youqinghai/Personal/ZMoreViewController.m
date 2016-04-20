//
//  ZMoreViewController.m
//  youqinghai
//
//  Created by snailz on 16/4/5.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "ZMoreViewController.h"
#import "UIViewController+TableView.h"
#import "ZImageFidCell.h"
#import "PersonalCell.h"
#import <SDWebImage/SDImageCache.h>
@interface ZMoreViewController ()<UIAlertViewDelegate>

@end

@implementation ZMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"更多";
     self.view.backgroundColor = spaceColor238238238();
    self.tableView.backgroundColor = [UIColor clearColor];
    // Do any additional setup after loading the view.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

{
    
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 12;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    // 下面这几行代码是用来设置cell的上下行线的位置
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 12, 0, 12)];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"PersonalCell";
    PersonalCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[PersonalCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.font = fontSystem14();
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = [UIColor colorWithRed:0.286 green:0.286 blue:0.298 alpha:1.000];
    }
    switch (indexPath.row) {
        case 0:
            cell.imageView.image = [UIImage imageNamed:@"userProtocol"];
            cell.textLabel.text = @"用户协议";
            break;
        case 1:
            cell.imageView.image = [UIImage imageNamed:@"useHelp"];
            cell.textLabel.text = @"使用帮助";
            break;
        case 2:
            cell.imageView.image = [UIImage imageNamed:@"AboutUs"];
            cell.textLabel.text = @"关于我们";
            break;
        case 3:
            cell.imageView.image = [UIImage imageNamed:@"cleancache"];
            cell.textLabel.text = @"清除缓存";
            break;
        
            
        default:
            break;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (indexPath.row == 3) {
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"" message:@"请问是否要清除缓存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"清除", nil];
        [alert show];
    }
   
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
         [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[SDImageCache sharedImageCache]cleanDiskWithCompletionBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                  [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"" message:@"已清除" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                [alert show];
            });
        }];
    }
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
