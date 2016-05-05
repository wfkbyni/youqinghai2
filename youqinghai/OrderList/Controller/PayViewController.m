//
//  PayViewController.m
//  youqinghai
//
//  Created by 舒永超 on 16/4/19.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "PayViewController.h"
#import "PayViewModel.h"
#import "PayInfo.h"

@interface PayViewController ()<UITableViewDelegate,UITableViewDataSource>{
    PayViewModel *viewModel;
}
@property (nonatomic, strong) UITableView *myTableView;
@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"支付";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    CGRect frame = CGRectMake(0, 0, kScreenSize.width, kScreenSize.height);
    
    _myTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    [_myTableView setDataSource:self];
    [_myTableView setDelegate:self];
    [_myTableView setTableFooterView:[UIView new]];
    [_myTableView setScrollEnabled:NO];
    [_myTableView setBackgroundColor:[UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.00]];
    
    [self.view addSubview:_myTableView];
    
    viewModel = [[PayViewModel alloc] init];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
            
        default:
            return 2;
            break;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 30.0f;
    }
    
    return 5.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 5, kScreenSize.width, 20)];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 160, 20)];
        [label1 setText:@"请选择支付方式"];
        [label1 setFont:[UIFont systemFontOfSize:15.0f]];
        
        [view addSubview:label1];
        
        return view;
    }

    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 44.0f;
            break;
        case 1:
            return 55.0f;
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        if (indexPath.section == 1) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else{
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    }
    
    switch (indexPath.section) {
        case 0:{
            UILabel *label1 = [cell viewWithTag:10001];
            if (!label1) {
                label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 12, 100, 20)];
                [label1 setText:@"请支付"];
                [label1 setFont:[UIFont systemFontOfSize:15.0f]];
                [cell.contentView addSubview:label1];
            }
            
            UILabel *label2 = [cell viewWithTag:10002];
            if (!label2) {
                label2 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenSize.width - 100 - 10, 12, 100, 20)];
                [label2 setText:[NSString stringWithFormat:@"%@",_orderListModel.orderReserve]];
                [label2 setTextColor:[UIColor colorWithRed:1.00 green:0.26 blue:0.01 alpha:1.00]];
                [label2 setTextAlignment:NSTextAlignmentRight];
                [label2 setFont:[UIFont systemFontOfSize:15.0f]];
                [cell.contentView addSubview:label2];
            }
            break;
        }
        case 1:{
            
            if (indexPath.row == 0) {
                [cell.imageView setImage:[UIImage imageNamed:@"lipay"]];
                cell.textLabel.text = @"支付宝支付";
                cell.detailTextLabel.text = @"使用支付宝安全支付";
            }else if(indexPath.row == 1){
                [cell.imageView setImage:[UIImage imageNamed:@"wxpay"]];
                cell.textLabel.text = @"微信支付";
                cell.detailTextLabel.text = @"使用微信安全支付";
            }
            break;
        }
        default:
            break;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section) {
        if (indexPath.row == 0) {
            
            [self alipayWithSubject:self.orderListModel.Typename withBody:@"无" withPrice:@"0.01"/*self.orderListModel.orderReserve*/ withOutTradeNo:self.orderListModel.ordernum];
            
        }else{
            
            [self wxWithOutTradeNo:self.orderListModel.ordernum withBody:@"无" withTotalFee:@"1"/*self.orderListModel.orderReserve*/];
        }
    }
}

- (void)alipayWithSubject:(NSString *)subject withBody:(NSString *)body withPrice:(NSString *)price withOutTradeNo:(NSString *)outTradeNo{
    RACSignal *singal = [viewModel getPayDemoActivityWithSubject:subject withBody:body withPrice:price withOutTradeNo:outTradeNo];
    [singal subscribeNext:^(PayInfo *payInfo) {
        [AISharedPay handleAlipay:payInfo.orderInfo paymentBlock:^(BOOL success, id object, NSString *msg) {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
            [av show];
            // [self.view makeToast:msg];
        }];
    } error:^(NSError *error) {
        
    } completed:^{
        
    }];
}

- (void)wxWithOutTradeNo:(NSString *)outTradeNo withBody:(NSString *)body withTotalFee:(NSString *)totalFee{
    RACSignal *signal = [viewModel getCreateOrderWithOutTradeNo:outTradeNo withBody:body withTotalFee:totalFee];
    [signal subscribeNext:^(NSDictionary *params) {
        [AISharedPay handleWeixinPayment:params paymentBlock:^(BOOL success, id object, NSString *msg) {
            // [self.view makeToast:msg];
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
            [av show];
            
        }];

    } error:^(NSError *error) {
        
    } completed:^{
        
    }];
}
@end
