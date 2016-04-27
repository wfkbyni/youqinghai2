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

@interface ConfirmOrderController (){
    NSInteger isInsurance;
}

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
    
    self.orderViewModel = [[OrderViewModel alloc] init];
    self.relationView.order = self.orderViewModel.order;
    self.orderViewModel.traveId = [[[NSUserDefaults standardUserDefaults] objectForKey:YQHTourisId] integerValue];
    self.orderViewModel.driverId = self.driverId;
    
    if (!_isCarpool) {
        self.relationView.travelNum = self.carDetail.seatsnum;
    }
    
    [RACObserve(self.relationView, frame) subscribeNext:^(id x) {
        
        [self.myScrollView setContentSize:CGSizeMake(kScreenSize.width, CGRectGetHeight(self.travelView.frame) + CGRectGetHeight(self.relationView.frame) + 50)];
        
    }];
    
    [RACObserve(self.travelView, mySeatsnum) subscribeNext:^(NSNumber *obj) {
        self.relationView.seatsnum = [obj integerValue];
        self.orderViewModel.order.travelnum = [obj integerValue];
    }];
    
    [RACObserve(self.travelView, viewlist) subscribeNext:^(NSNumber *x) {
        self.relationView.days = [x integerValue];
    }];
    
    [RACObserve(self.relationView, totalMoeny) subscribeNext:^(id x) {
        self.submitOrderView.totalMoneyLab.text = [NSString stringWithFormat:@"￥%@",x];
    }];
    
    self.relationView.isCarpool = _isCarpool;
    
    [self getData];
}

- (void)popViewController{
    
    [CardNo removeAllCachedObjectsSuccess:^(NSArray *array) {
        
    } failure:^(NSError *error) {
        
    }];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getData{
    if (_isCarpool) {
        [self loadCalcPrice];
    }else{
        [self requestCalcCharteredPriceData];
    }
}

- (void)loadCalcPrice{
    [[self.orderViewModel calcPrice] subscribeNext:^(CalcPrice *calcPrice) {
        
        self.relationView.calcPrice = calcPrice;
        self.travelView.calcPrice = calcPrice;

    } error:^(NSError *error) {
        YQHLog(@"%@",error);
    }];
    
    [RACObserve(self.orderViewModel, cPrice) subscribeNext:^(CalcPrice *cPrice) {
        self.travelView.calcPrice = cPrice;
    }];
}

// 获取包车价格
- (void)requestCalcCharteredPriceData{
    
    [[self.orderViewModel calcCharteredPriceWihtIsInsurance:isInsurance] subscribeNext:^(CalCarPrice *calCarPrice) {
        
        self.relationView.calCarPrice = calCarPrice;
        self.travelView.calCarPrice = calCarPrice;

        
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
                weakSelf.relationView.travelNum = [value integerValue];
                weakSelf.orderViewModel.order.travelnum = [value integerValue];
            }else if(type == TravelTypeWithType){
                weakSelf.relationView.carType = value;
            }
        }];
    }
    return _travelView;
}

-(RelationView *)relationView{
    
    if (!_relationView) {
        _relationView = [[RelationView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.travelView.frame) + 10, kScreenSize.width, 250 + 130)];
        _relationView.navigationController = self.navigationController;
        @weakify(self)
        [_relationView setReturnSomingValue:^(ValueType type, id obj) {
            @strongify(self)
            switch (type) {
                case ValueTypeWithInsuranceCount:
                    isInsurance = [(NSArray *)obj count];
                    [self getData];
                    break;
                    
                default:
                    break;
            }
        }];
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
    self.orderViewModel.order.insuranceData = self.relationView.insuranceArray;
    
    if (self.orderViewModel.order.contacts.length == 0) {
        [self.view makeToast:@"联系人不能为空"];
        return;
    }else if(self.orderViewModel.order.contactsTel.length != 11){
        [self.view makeToast:@"联系人电话输入不正确"];
        return;
    }else if(self.orderViewModel.order.urgent.length == 0){
        [self.view makeToast:@"紧急联系人不能为空"];
        return;
    }else if(self.orderViewModel.order.urgentTel.length != 11){
        [self.view makeToast:@"紧急联系人电话输入不正确"];
        return;
    }
    
    [[self.orderViewModel addOrder] subscribeNext:^(id x) {
        NSLog(@"%@",x);
        [self.view makeToast:@"订单添加成功，请到我的订单查看"];
        [CardNo removeAllCachedObjectsSuccess:^(NSArray *array) {
            
            
        } failure:^(NSError *error) {
            
        }];
    } error:^(NSError *error) {
        [self.view makeToast:[error.userInfo objectForKey:@"message"]];
    }];
}

@end
