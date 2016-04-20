//
//  ZCWhyViewController.m
//  youqinghai
//
//  Created by snailz on 16/4/20.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "ZCWhyViewController.h"
#import "UIViewController+TableView.h"
@interface ZCWhyViewController ()
@property(nonatomic,strong)NSArray *array;
@end

@implementation ZCWhyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"投诉司机";
    self.view.backgroundColor = spaceColor238238238();
    self.tableView.backgroundColor = [UIColor clearColor];
    self.array = @[@"司机未如约而至",@"受到司机骚扰",@"司机选择的线路有问题",@"司机额外收费",@"司机未完成订单"];
    // Do any additional setup after loading the view.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

{
    return self.array.count;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    // 下面这几行代码是用来设置cell的上下行线的位置
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 12, 0, 12)];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
   
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.textLabel.text = self.array[indexPath.row];
    
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
  
 
}
- (void)tableView:(UITableView *)tableViewv didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    [tableViewv deselectRowAtIndexPath:indexPath animated:YES];
    if (self.selectBlock) {
        self.selectBlock(self.array[indexPath.row]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 12;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
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
