//
//  ConfirmOrderController.m
//  youqinghai
//
//  Created by 舒永超 on 16/4/5.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "ConfirmOrderController.h"

#import "TravelView.h"
#import "RelationView.h"
#import "CalculateView.h"
#import "SubmitOrderView.h"

#import "OrderViewModel.h"

@interface ConfirmOrderController ()

@property (nonatomic, strong) UIScrollView *myScrollView;

// 出行view
@property (nonatomic, strong) TravelView *travelView;
// 联系人view
@property (nonatomic, strong) RelationView *relationView;
// 结算view
@property (nonatomic, strong) CalculateView *calculateView;
// 提交订单view
@property (nonatomic, strong) SubmitOrderView *submitOrderView;

@property (nonatomic, strong) OrderViewModel *orderViewModel;
@end

@implementation ConfirmOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"确认订单";
    
    [self.view setBackgroundColor:[UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1.00]];
    
    [self.view addSubview:self.myScrollView];
    
    [self.myScrollView addSubview:self.travelView];
    [self.myScrollView addSubview:self.relationView];
    [self.myScrollView addSubview:self.calculateView];
    
    [self.myScrollView setContentSize:CGSizeMake(kScreenSize.width, CGRectGetHeight(self.travelView.frame) + CGRectGetHeight(self.relationView.frame) + CGRectGetHeight(self.calculateView.frame) + 50)];
    
    [self.view addSubview:self.submitOrderView];

    [self requestData];
}

- (void)requestData{
    self.orderViewModel = [[OrderViewModel alloc] init];
    self.relationView.order = self.orderViewModel.order;
    self.orderViewModel.traveId = self.traveId;
    self.orderViewModel.carTypeId = self.carTypeId;
    
    [[self.orderViewModel calcCharteredPrice] subscribeNext:^(id x) {
        
        
    } error:^(NSError *error) {
        YQHLog(@"%@",error);
    }];
    
}

- (UIScrollView *)myScrollView{
    if (!_myScrollView) {
        CGRect frame = self.view.frame;
        frame.size.height = frame.size.height - 50;
        _myScrollView = [[UIScrollView alloc] initWithFrame:frame];
    }
    return _myScrollView;
}

-(TravelView *)travelView{
    if (!_travelView) {
        _travelView = [[TravelView alloc] initWithFrame:CGRectMake(0, 10, kScreenSize.width, 150)];
    }
    return _travelView;
}

-(RelationView *)relationView{
    
    if (!_relationView) {
        _relationView = [[RelationView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.travelView.frame) + 10, kScreenSize.width, 250)];
    }
    
    return _relationView;
}

- (CalculateView *)calculateView{
    if (!_calculateView) {
        _calculateView = [[CalculateView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.relationView.frame) + 10, kScreenSize.width, 120)];
    }
    return _calculateView;
}

- (SubmitOrderView *)submitOrderView{
    if (!_submitOrderView) {
        _submitOrderView = [[SubmitOrderView alloc] initWithFrame:CGRectMake(0, kScreenSize.height - 50, kScreenSize.width, 50)];
        @weakify(self)
        [_submitOrderView setSubmitOrderAction:^{
            @strongify(self)
            NSLog(@"%@",self.orderViewModel.order.contactsTel);
        }];
    }
    return _submitOrderView;
}

@end
