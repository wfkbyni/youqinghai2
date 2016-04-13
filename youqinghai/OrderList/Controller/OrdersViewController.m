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

@interface OrdersViewController ()<ZPageViewDelegate>{
    NSInteger orderState;   // 订单状态
}
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
    
    orderState = -1;
    
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
    self.tableView.mj_footer.hidden = YES;
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
    RACSignal *signal  = [self.orderViewModel getUserOrderList:orderState];
    [signal subscribeNext:^(id x) {
                 endRefesh
         self.tableView.mj_footer.hidden = NO;
        
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
        self.tableView.mj_footer.hidden = NO;
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
    OrderListModel *model = self.listAr[indexPath.section];
    cell.orderListMod = model;
    [cell setBtnClickType:^(OrderType orderType) {
        
        if (orderType == OrderTypeWithCancel) {
            // 取消订单
            [self cancelOrder:model];
        }else if(orderType == OrderTypeWithConfirmPay){
            // 立即支付
            [self confirmOrder:model];
        }else if(orderType == OrderTypeWithDeleteOrder){
            // 删除订单
            [self deleteOrder:model];
        }else if(orderType == OrderTypeWithEvaluate){
            // 评价订单
        }else if(orderType == OrderTypeWithComplaintPay){
            // 投诉司机
        }
    }];
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
    __weak typeof(OrdersViewController) *weakSelf = self;
    [_pageView setSelectIndexAction:^(NSInteger index) {
        [self.listAr removeAllObjects];
        self.orderViewModel.pages = @"1";
        orderState = index - 1;
        [weakSelf.pageView selectedIndex:@(index)];
        [weakSelf loadOrderListData];
    }];
    return page;
}

- (void)cancelOrder:(OrderListModel *)model{
    [[self.orderViewModel cancelOrderWithOrderNo:model.orderId] subscribeNext:^(ResponseBaseData *data) {
       
        [self.view makeToast:data.message];
        if (data.result_code == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } error:^(NSError *error) {
        YQHLog(@"%@",error);
    }];
}

- (void)confirmOrder:(OrderListModel *)model{
    
    [[self.orderViewModel notifyUrlWithOrderNo:model.orderId withTotalMoney:model.orderReserve] subscribeNext:^(ResponseBaseData *data) {
        
        [self.view makeToast:data.message];
        if (data.result_code == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } error:^(NSError *error) {
        YQHLog(@"%@",error);
    }];
    
//    [AISharedPay handleAlipay:nil paymentBlock:^(BOOL success, id object, NSString *msg) {
//        
//    }];
}

- (void)deleteOrder:(OrderListModel *)model{
    [[self.orderViewModel deleteOrder:model.orderId] subscribeNext:^(ResponseBaseData *data) {
        
        [self.view makeToast:data.message];
        if (data.result_code == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
        }
    } error:^(NSError *error) {
        YQHLog(@"%@",error);
    }];
}
@end
