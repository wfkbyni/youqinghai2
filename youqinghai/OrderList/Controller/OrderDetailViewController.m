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
#import "ZComplaintsViewController.h"
#import "MyOrderEvaViewController.h"
#import "PayViewController.h"
@interface OrderDetailViewController () {

    YQHRadiusButton *_confirmPayBt;
    YQHRadiusButton *_cancelBt;
    
    CGFloat _cancelX,_confirmX;
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
    
    self.tableView.tableFooterView = self.tableViewFooterView;
    [self.view addSubview:self.footerView];
    
    _datasourceOfTitles = [NSMutableArray array];
    _datasourceOfValues = [NSMutableArray array];
    
    NSArray *titles1 = @[@"订单号",@"下单时间",@"订单状态"];
    NSArray *titles2 = @[@"出游路线",@"出游日期",@"出游人数",@"出游天数",@"车辆类型",@"订单金额",@"支付定金"];
    NSArray *titles3 = @[@"服务司机",@"服务车辆",@"联系人",@"联系电话",@"紧急联系人",@"紧急电话",@"是否购买保险"];
    [_datasourceOfTitles addObject:titles1];
    [_datasourceOfTitles addObject:titles2];
    [_datasourceOfTitles addObject:titles3];
    _cancelBt.hidden = NO;
    _confirmPayBt.hidden = NO;
    NSString *Statype;
    switch (_orderListMod.state.integerValue) {
        case 0:
            Statype = @"待付款";
            break;
        case 1:
            Statype = @"待完成";
            [_cancelBt setTitle:@"投诉司机" forState:UIControlStateNormal];
            _confirmPayBt.hidden = YES;
            [_cancelBt setX:_confirmX];
            break;
        case 2:
            Statype = @"待评价";
            _cancelBt.hidden = YES;
            [_confirmPayBt setTitle:@"立即评价" forState:UIControlStateNormal];

            break;
        case 3:
            Statype = @"已完成";
            [_confirmPayBt setTitle:@"删除订单" forState:UIControlStateNormal];
            _cancelBt.hidden = YES;

            break;
        case 4:
            Statype = @"取消订单";
            [_confirmPayBt setTitle:@"删除订单" forState:UIControlStateNormal];
            _cancelBt.hidden = YES;
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
    if ([title isEqualToString:@"服务司机"]) {
        UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"myorderphone"]];
        image.frame = CGRectMake(0, 0, 28, 28);
        cell.accessoryView =image;
    }
    NSArray *values = _datasourceOfValues[indexPath.section];
    NSString *value = values[indexPath.row];
    
    if ([title hasPrefix:@"订单金额"]||[title hasPrefix:@"支付定金"]) {
        cell.detailTextLabel.textColor = [UIColor redColor];
    }else{
        cell.detailTextLabel.textColor = [UIColor colorWithWhite:0.667 alpha:1.000];
    }
    
    cell.textLabel.text = title;
    cell.textLabel.textColor = [UIColor colorWithRed:0.286 green:0.286 blue:0.298 alpha:1.000];
    cell.detailTextLabel.text = value;
    return cell;
}
-(void)tableView:(UITableView *)tableView  didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (indexPath.section ==2&&indexPath.row==0) {
        if (self.orderListMod.phone.length > 0) {
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.orderListMod.phone];
            UIWebView * callWebview = [[UIWebView alloc] init];
            [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
            [self.view addSubview:callWebview];
        }else{
            [self.view makeToast:@"未提供电话号码."];
        }
       
    }
}
- (UIView *)footerView {

    UIView *lView = UIView.new;
    CGRect frame = self.view.frame;
    frame.size.height = 60;
    frame.origin.y = self.view.height - 60;
    lView.frame = frame;
    lView.backgroundColor = [UIColor whiteColor];
    
    
    UIColor *color = [UIColor redColor];
    
    _confirmPayBt = [YQHRadiusButton createWithTitle:@"立即支付" withColor:color];
    
    [_confirmPayBt setOrigin:CGPointMake(self.view.width - _confirmPayBt.width-10,(lView.height - _confirmPayBt.height)/2)];
    [lView addSubview:_confirmPayBt];

    
     color = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1];
    
    _cancelBt = [YQHRadiusButton createWithTitle:@"取消订单" withColor:color];
    
    [_cancelBt setOrigin:CGPointMake(_confirmPayBt.x-_cancelBt.width - 5,_confirmPayBt.y)];

    [_cancelBt addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmPayBt addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];

    [lView addSubview:_cancelBt];
    
    
    _cancelX = _cancelBt.x;
    _confirmX = _confirmPayBt.x;
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


- (IBAction)buttonClicked:(UIButton *)sender {

    NSString *title = sender.titleLabel.text;
    if ([title hasPrefix:@"投诉司机"]) {
        ZComplaintsViewController *cvc = [[ZComplaintsViewController alloc]init];
        cvc.listMod = self.orderListMod;
        [self.navigationController pushViewController:cvc animated:YES];
    }else if ([title hasPrefix:@"立即评价"]) {
    
        MyOrderEvaViewController *oev = [[MyOrderEvaViewController alloc]init];
        oev.listMod = self.orderListMod;
        [self.navigationController pushViewController:oev animated:YES];
    }else if ([title hasPrefix:@"立即支付"]) {
    
        [self confirmOrder];
    }else if ([title hasPrefix:@"取消订单"]) {
        
        [self showAlertWithTag:2];
    }else if ([title hasPrefix:@"删除订单"]) {
        
        [self showAlertWithTag:1];
    }
    
}

 - (void)confirmOrder{
    
    PayViewController *controller = [[PayViewController alloc] init];
    controller.orderListModel = self.orderListMod;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)cancelOrder{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[self.orderViewModel cancelOrderWithOrderNo:self.orderListMod.orderId] subscribeNext:^(ResponseBaseData *data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.view makeToast:data.message];
        if (data.result_code == 0) {
            
            self.orderListMod.state = @"4";
            [self.tableView reloadData];
            //   [self.navigationController popViewControllerAnimated:YES];
        }
    } error:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        YQHLog(@"%@",error);
    }];
}


- (void)deleteOrder{
    [[self.orderViewModel deleteOrder:self.orderListMod.orderId] subscribeNext:^(ResponseBaseData *data) {
        
        [self.view makeToast:data.message];
        if (data.result_code == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
        }
    } error:^(NSError *error) {
        YQHLog(@"%@",error);
    }];
}


- (void) showAlertWithTag:(NSInteger)tag {
    
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定要删除该订单吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    av.tag = tag;
    [av show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    if (buttonIndex == 1) {
        
        if (alertView.tag == 1) {
            //删除定单
            [self deleteOrder];
        }else if (alertView.tag == 2) {
            [self cancelOrder];
        }
    }
}

@end
