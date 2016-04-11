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
@property(weak,nonatomic)ZPageView *pageView;
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
  
 
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    self.tableView.mj_header = header;
    
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.orderViewModel.pages = @(self.orderViewModel.pages.integerValue+1).stringValue;
        [self loadOrderListData];
    }];
    [self.tableView.mj_header beginRefreshing];
}
-(void)headerRefresh
{
    self.orderViewModel.pages = @"1";
    [self loadOrderListData];
}
- (void)loadOrderListData{
    
    
//    [RACObserve(self.orderViewModel, orderList) subscribeNext:^(id x) {
//         [self.tableView.mj_header endRefreshing];
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//        if (self.orderViewModel.pages.integerValue!=1) {
//            [self.orlistAr addObjectsFromArray:x];
//            [self.listAr addObjectsFromArray:x];
//            [self.tableView reloadData];
//            return ;
//        }
//        
//        self.orlistAr = x;
//        self.listAr = x;
//        [self.tableView reloadData];
//       
//    }];
    RACSignal *signal  = [self.orderViewModel getUserOrderList];
    [self.pageView selectedIndex:@(0)];
    [signal subscribeNext:^(id x) {
                 endRefesh
              
       x =  [OrderListModel mj_objectArrayWithKeyValuesArray:x];
                if (self.orderViewModel.pages.integerValue!=1) {
                    if ([(NSArray*)x count]) {
                        [self.orlistAr addObjectsFromArray:x];
                        [self.listAr addObjectsFromArray:x];
                        [self.tableView reloadData];
                    }else{
                        [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    }

                    return ;
                }
        
                self.orlistAr = x;
                self.listAr = x;
                [self.tableView reloadData];
    }];
    [signal subscribeError:^(NSError *error) {
        endRefesh
        
        int code = [[error.userInfo objectForKey:@"result_code"] intValue];
        if (code == 1) {
            self.orderViewModel.orders = @[];
            [self.tableView reloadData];
        }
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
    _pageView = page;
    return page;
}
@end
