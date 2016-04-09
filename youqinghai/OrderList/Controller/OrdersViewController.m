//
//  OrdersViewController.m
//  youqinghai
//
//  Created by mouxiaochun on 16/4/8.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "OrdersViewController.h"
#import "UIViewController+TableView.h"
#import "ZPageView.h"
#import "OrderListCell.h"
#import "OrderDetailViewController.h"
#import "OrderViewModel.h"

@interface OrdersViewController ()

{}
@property (nonatomic, strong) OrderViewModel *orderViewModel;

@end

@implementation OrdersViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.tableView.tableHeaderView = self.tableViewHeader;
    
    self.view.backgroundColor = [UIColor colorWithRed:236.0/255.0 green:237.0/255.0 blue:238.0/255.0 alpha:1];
    
    self.title = @"我的订单";
    
    [self loadOrderListData];
}
- (void)loadOrderListData{
    
    [RACObserve(self.orderViewModel, orders) subscribeNext:^(id x) {
        [self.tableView reloadData];
    }];
    
    [[self.orderViewModel getUserOrderList] subscribeError:^(NSError *error) {
        int code = [[error.userInfo objectForKey:@"result_code"] intValue];
        if (code == 1) {
            self.orderViewModel.orders = @[];
            [self.tableView reloadData];
        }
    } completed:^{
        
    }];
}

#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    static  NSString *identify = @"OrderListCell";
    OrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[OrderListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identify];
    }
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 220.0f;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderDetailViewController *mOrderDetailViewController = [[OrderDetailViewController alloc] init];
    [self.navigationController pushViewController:mOrderDetailViewController animated:YES];
}

#pragma mark -- setter && getter

- (UIView *)tableViewHeader {

    CGRect frame = self.view.bounds;
    frame.size.height = 44;
    ZPageView *page = [[ZPageView alloc] initWithFrame:frame];
    NSArray *titles = @[@"全部",@"待付款",@"待完成",@"待评价",@"已完成"];
    page.dataS = titles;
    return page;
}
@end
