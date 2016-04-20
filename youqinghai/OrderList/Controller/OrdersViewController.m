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
#import "MyOrderEvaViewController.h"
#import "PayViewController.h"

@interface OrdersViewController ()<ZPageViewDelegate>{
    NSInteger orderState;   // 订单状态
}
@property (nonatomic, strong) OrderViewModel *orderViewModel;

@property(strong,nonatomic)NSMutableArray *listAr;//订单数据
@property(weak,nonatomic)ZPageView *pageView;//选择器

@end

@implementation OrdersViewController
-(void)pageView:(ZPageView *)pageView button:(UIButton *)btn
{
    
//self.state =btn.tag-1;
    //    _listAr = [NSMutableArray array];
    //    for (OrderListModel *listM in self.orlistAr) {
    //        if (listM.state.integerValue == btn.tag) {
    //            [_listAr addObject:listM];
    //        }
    //    }
   // [self.tableView reloadData];
    
}
- (void)viewDidLoad {

    [super viewDidLoad];
    
    orderState = -1;
    
    self.orderViewModel = [[OrderViewModel alloc]init];
    //self.tableView.tableHeaderView = self.tableViewHeader;
    [self tableViewHeader];;
    self.tableView.frame = CGRectMake(0, 108, self.view.frame.size.width, self.view.frame.size.height-108);
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
                  
                        [self.listAr addObjectsFromArray:x];
                        [self.tableView reloadData];
                    }else{
                        [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    }

                    return ;
                }
        
        
                self.listAr = x;
        if (self.listAr.count<10) {
             [self.tableView.mj_footer endRefreshingWithNoMoreData];
            
        }
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
            {
                MyOrderEvaViewController *oev = [[MyOrderEvaViewController alloc]init];
                oev.listMod = model;
                [self.navigationController pushViewController:oev animated:YES];
            }
        }else if(orderType == OrderTypeWithComplaintPay){
            // 投诉司机
        }
    }];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 220.0f;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    // 下面这几行代码是用来设置cell的上下行线的位置
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 20, 0, 20)];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderListModel *lm = self.listAr[indexPath.section];
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
    page.frame = CGRectMake(0,64, frame.size.width, 44);
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
    [self.view addSubview:self.pageView];
    return page;
}

- (void)cancelOrder:(OrderListModel *)model{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[self.orderViewModel cancelOrderWithOrderNo:model.orderId] subscribeNext:^(ResponseBaseData *data) {
       [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.view makeToast:data.message];
        if (data.result_code == 0) {

            model.state = @"4";
            [self.tableView reloadData];
         //   [self.navigationController popViewControllerAnimated:YES];
        }
    } error:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        YQHLog(@"%@",error);
    }];
}

- (void)confirmOrder:(OrderListModel *)model{
    
    PayViewController *controller = [[PayViewController alloc] init];
    controller.orderListModel = model;
    [self.navigationController pushViewController:controller animated:YES];
    
//    [[self.orderViewModel notifyUrlWithOrderNo:model.orderId withTotalMoney:model.orderReserve] subscribeNext:^(ResponseBaseData *data) {
//        
//        [self.view makeToast:data.message];
//        if (data.result_code == 0) {
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//        
//    } error:^(NSError *error) {
//        [self.view makeToast:[error.userInfo objectForKey:@"message"]];
//    }];
    
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
