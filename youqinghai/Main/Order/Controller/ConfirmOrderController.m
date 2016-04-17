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
#import "CarViewModel.h"

@interface ConfirmOrderController ()

@property (nonatomic, strong) UIScrollView *myScrollView;

// 出行view
@property (nonatomic, strong) TravelView *travelView;
// 联系人view
@property (nonatomic, strong) RelationView *relationView;
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
    
    [self.view addSubview:self.submitOrderView];
    
    [RACObserve(self.relationView, frame) subscribeNext:^(id x) {
        
        [self.myScrollView setContentSize:CGSizeMake(kScreenSize.width, CGRectGetHeight(self.travelView.frame) + CGRectGetHeight(self.relationView.frame) + 50)];
        
    }];
    
    [RACObserve(self.travelView, seatsnum) subscribeNext:^(NSNumber *obj) {
        self.relationView.seatsnum = [obj intValue];
    }];
    
    self.orderViewModel = [[OrderViewModel alloc] init];
    self.relationView.order = self.orderViewModel.order;
    self.orderViewModel.traveId = [[[NSUserDefaults standardUserDefaults] objectForKey:YQHTourisId] integerValue];
    self.orderViewModel.driverId = self.driverId;
    
    self.relationView.isCarpool = _isCarpool;
    if (_isCarpool) {
        [self loadCalcPrice];
    }else{
        [self requestCalcCharteredPriceData];
    }
}

- (void)loadCalcPrice{
    [[self.orderViewModel calcPrice] subscribeNext:^(CalcPrice *calcPrice) {
        
        self.relationView.calcPrice = calcPrice;
        
    } error:^(NSError *error) {
        YQHLog(@"%@",error);
    }];
    
    [RACObserve(self.orderViewModel, cPrice) subscribeNext:^(CalcPrice *cPrice) {
        self.travelView.calcPrice = cPrice;
    }];
}

// 获取包车价格
- (void)requestCalcCharteredPriceData{
    
    [[self.orderViewModel calcCharteredPrice] subscribeNext:^(CalCarPrice *calCarPrice) {
        
        self.relationView.calCarPrice = calCarPrice;
        
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
        _travelView = [[TravelView alloc] initWithFrame:CGRectMake(0, 10, kScreenSize.width, _isCarpool ? 50 * 4 : 50 * 3) withIsTrave:_isCarpool];
        _travelView.navigationController = self.navigationController;
        if (self.carDetail) {
            _travelView.carDetail = self.carDetail;
        } else {
             _travelView.carDetail = [CarDetail new];
        }
       
        
        __weak typeof(self) weakSelf = self;
        [_travelView setTravelSelectBlock:^(TravelType type, id value) {
            if (type == TravelTypeWithDate) {
                NSDate *date = value;
                weakSelf.orderViewModel.order.travelTime = [date timeIntervalSince1970] * 1000;
            }else if(type == TravelTypeWithCount){
                weakSelf.orderViewModel.order.travelnum = [value integerValue];
            }
        }];
    }
    return _travelView;
}

-(RelationView *)relationView{
    
    if (!_relationView) {
        _relationView = [[RelationView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.travelView.frame) + 10, kScreenSize.width, 250 + 130)];
        _relationView.navigationController = self.navigationController;
    }
    
    return _relationView;
}

- (SubmitOrderView *)submitOrderView{
    if (!_submitOrderView) {
        _submitOrderView = [[SubmitOrderView alloc] initWithFrame:CGRectMake(0, kScreenSize.height - 50, kScreenSize.width, 50)];
        @weakify(self)
        [_submitOrderView setSubmitOrderAction:^{
            @strongify(self)
            NSLog(@"%@",self.orderViewModel.order.contactsTel);
            [self confirmOrder];
        }];
    }
    return _submitOrderView;
}

- (void)confirmOrder{
    
    self.orderViewModel.order.userId = [[ZUserModel shareUserModel].userId integerValue];
    self.orderViewModel.order.traveld = [[[NSUserDefaults standardUserDefaults] objectForKey:YQHTourisId] integerValue];
    self.orderViewModel.order.carTypeId = _isCarpool ? self.travelView.carDetail.cartypeId : self.carDetail.cartypeId;
    self.orderViewModel.order.traveltype = !_isCarpool;
    self.orderViewModel.order.insuranceCost = self.relationView.insuranceCount;
    self.orderViewModel.order.driverId = self.driverId;
    
    [[self.orderViewModel addOrder] subscribeNext:^(id x) {
        NSLog(@"%@",x);
        
    } error:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

@end
