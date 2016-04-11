//
//  OrderDetailViewController.m
//  youqinghai
//
//  Created by mouxiaochun on 16/4/8.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "UIViewController+TableView.h"
#import "OrderListDetailCell.h"
#import "YQHRadiusButton.h"
#import "OrderViewModel.h"

@interface OrderDetailViewController () {

}
@property (nonatomic, strong) OrderViewModel *orderViewModel;
@property (nonatomic, strong) NSMutableArray *datasourceOfTitles;
@property (nonatomic, strong) NSMutableArray *datasourceOfValues;
@property(strong,nonatomic)OrderListModel *orderListMod;

@end

@implementation OrderDetailViewController

- (instancetype)init{

    self = [super init];
    if (self) {
        
     }
    return self;
}

- (void)viewDidLoad {

    [super viewDidLoad];
       self.orderViewModel = [[OrderViewModel alloc]init];
    self.view.backgroundColor = [UIColor colorWithRed:236.0/255.0 green:237.0/255.0 blue:238.0/255.0 alpha:1];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.title = @"订单详情";
    
    [self getNetData];
}
-(void)getNetData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [RACObserve(self.orderViewModel, orderList) subscribeNext:^(id x) {
        self.orderListMod = x[0];
        if (self.orderListMod) {
             [self commonInit];
        }
       
        [self.tableView reloadData];
          [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    [[self.orderViewModel getUserOrderDetail:self.ID] subscribeError:^(NSError *error) {
          [MBProgressHUD hideHUDForView:self.view animated:YES];
        int code = [[error.userInfo objectForKey:@"result_code"] intValue];
        if (code == 1) {
            self.orderViewModel.orders = @[];
            [self.tableView reloadData];
        }
    } completed:^{
        
    }];
}

- (void)commonInit {
    _datasourceOfTitles = [NSMutableArray array];
    _datasourceOfValues = [NSMutableArray array];
    
    NSArray *titles1 = @[@"订单号",@"下单时间",@"订单状态"];
    NSArray *titles2 = @[@"出游路线",@"出游日期",@"出游人数",@"出游天数",@"车辆类型",@"订单金额",@"支付定金"];
    NSArray *titles3 = @[@"服务司机",@"服务车辆",@"联系人",@"联系电话",@"紧急联系人",@"紧急电话",@"是否购买保险"];
    [_datasourceOfTitles addObject:titles1];
    [_datasourceOfTitles addObject:titles2];
    [_datasourceOfTitles addObject:titles3];
    NSString *Statype;
    switch (_orderListMod.state.integerValue) {
        case 0:
            Statype = @"待付款";
            break;
        case 1:
            Statype = @"待完成";
            break;
        case 2:
            Statype = @"待评价";
            break;
        case 3:
            Statype = @"已完成";
            break;
        case 4:
            Statype = @"取消订单";
            break;
        default:
            break;
    }
    NSString *mom = @"￥";
    
    
    NSArray *values1 = @[_orderListMod.orderNum,_orderListMod.singletime,Statype];
    NSArray *values2 = @[_orderListMod.tourName,_orderListMod.travelTime,[_orderListMod.travelnum stringByAppendingString:@"人"],[_orderListMod.dayNum stringByAppendingString:@"天"],_orderListMod.carTypeName,[mom stringByAppendingString:_orderListMod.orderMoney],[mom stringByAppendingString:_orderListMod.orderReserve]];
    NSArray *values3 = @[_orderListMod.nickname,_orderListMod.carname,_orderListMod.contacts,_orderListMod.contactsTel,_orderListMod.urgent,_orderListMod.urgentTel,_orderListMod.insuranceCost.integerValue?@"  是":@"  否"];
    [_datasourceOfValues addObject:values1];
    [_datasourceOfValues addObject:values2];
    [_datasourceOfValues addObject:values3];
    
    
    
    self.tableView.tableFooterView = self.tableViewFooterView;
    [self.view addSubview:self.footerView];

}


#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _datasourceOfTitles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *list = _datasourceOfTitles[section];
    return list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static  NSString *identify = @"OrderListDetailCell";
    OrderListDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[OrderListDetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSArray *list = _datasourceOfTitles[indexPath.section];
    NSString *title = list[indexPath.row];
    NSArray *values = _datasourceOfValues[indexPath.section];
    NSString *value = values[indexPath.row];
    
    if ([title hasPrefix:@"订单金额"]||[title hasPrefix:@"支付定金"]) {
        cell.detailTextLabel.textColor = [UIColor redColor];
    }else{
        cell.detailTextLabel.textColor = [UIColor colorWithRed:3.0/255.0 green:3.0/255.0 blue:3.0/255.0 alpha:1.0f];
    }
    
    cell.textLabel.text = title;
    cell.detailTextLabel.text = value;
    return cell;
}


- (UIView *)footerView {

    UIView *lView = UIView.new;
    CGRect frame = self.view.frame;
    frame.size.height = 60;
    frame.origin.y = self.view.height - 60;
    lView.frame = frame;
    lView.backgroundColor = [UIColor whiteColor];
    
    
    UIColor *color = [UIColor redColor];
    
    YQHRadiusButton *confirmPayBt = [YQHRadiusButton createWithTitle:@"立即支付" withColor:color];
    
    [confirmPayBt setOrigin:CGPointMake(self.view.width - confirmPayBt.width-10,(lView.height - confirmPayBt.height)/2)];
    [lView addSubview:confirmPayBt];

    
     color = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1];
    
    YQHRadiusButton *cancelBt = [YQHRadiusButton createWithTitle:@"取消订单" withColor:color];
    
    [cancelBt setOrigin:CGPointMake(confirmPayBt.x-cancelBt.width - 5,confirmPayBt.y)];
    [lView addSubview:cancelBt];
    
    lView.layer.borderWidth = 0.5;
    lView.layer.masksToBounds = YES;
    lView.layer.borderColor = color.CGColor;
   
    return lView;
}


- (UIView *)tableViewFooterView {

    UIView *lView = UIView.new;
    CGRect frame = self.view.frame;
    frame.size.height = 60;
    lView.frame = frame;
    lView.backgroundColor = [UIColor clearColor];
    return lView;
}



@end
