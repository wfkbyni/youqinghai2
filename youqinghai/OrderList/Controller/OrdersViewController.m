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

@interface OrdersViewController ()<ZPageViewDelegate>

{}
@property (nonatomic, strong) OrderViewModel *orderViewModel;
@property(strong,nonatomic)NSMutableArray *orlistAr;
@property(strong,nonatomic)NSMutableArray *listAr;
@end

@implementation OrdersViewController
-(void)pageView:(ZPageView *)pageView button:(UIButton *)btn
{
    _listAr = [NSMutableArray array];
    for (OrderListModel *listM in self.orlistAr) {
        if (listM.state.integerValue == btn.tag) {
            [_listAr addObject:listM];
        }
    }
    [self.tableView reloadData];
}
- (void)viewDidLoad {

    [super viewDidLoad];
    self.orderViewModel = [[OrderViewModel alloc]init];
    self.tableView.tableHeaderView = self.tableViewHeader;
    
    self.view.backgroundColor = [UIColor colorWithRed:236.0/255.0 green:237.0/255.0 blue:238.0/255.0 alpha:1];
    
    self.title = @"我的订单";
    
    [self loadOrderListData];
}
- (void)loadOrderListData{
    
    [RACObserve(self.orderViewModel, orderList) subscribeNext:^(id x) {
        self.orlistAr = x;
        self.listAr = x;
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
    return self.listAr.count;
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
    cell.orderListMod = self.listAr[indexPath.section];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 220.0f;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderListModel *lm = self.listAr[indexPath.row];
    OrderDetailViewController *mOrderDetailViewController = [[OrderDetailViewController alloc] init];
    mOrderDetailViewController.ID = lm.orderId;
    [self.navigationController pushViewController:mOrderDetailViewController animated:YES];
}

#pragma mark -- setter && getter

- (UIView *)tableViewHeader {

    CGRect frame = self.view.bounds;
    frame.size.height = 44;
    ZPageView *page = [[ZPageView alloc] initWithFrame:frame];
    page.delegate =self;
    NSArray *titles = @[@"全部",@"待付款",@"待完成",@"待评价",@"已完成"];
    page.dataS = titles;
    return page;
}
@end
