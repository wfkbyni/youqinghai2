//
//  OrderViewModel.m
//  youqinghai
//
//  Created by 舒永超 on 16/4/6.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "OrderViewModel.h"
#import "RequestBaseAPI+Order.h"

@implementation OrderViewModel

-(instancetype)init{
    if (self = [super init]) {
        _order = [[Order alloc] init];
        self.pages = @"";
    }
    return self;
}

-(RACSignal *)calcCharteredPriceWihtIsInsurance:(NSInteger)isInsurance{
    
    RACSignal *signal = [[[RequestBaseAPI standardAPI] calcCharteredPriceWithTraveId:self.traveId withCarTypeId:self.driverId withIsInsurance:isInsurance] map:^id(ResponseBaseData *data) {
        
        self.calCarPrice = [CalCarPrice mj_objectWithKeyValues:data.result_data];
        
        return self.calCarPrice;
    }];
    
    return signal;
}

-(RACSignal *)calcPriceWithTraveId:(NSInteger)traveId
                     withCarTypeId:(NSInteger)carTypeId
                     withTravelNum:(NSInteger)travelNum
                   withIsInsurance:(NSInteger)isInsurance{
    RACSignal *signal = [[[RequestBaseAPI standardAPI] calcPriceWithTraveId:traveId withCarTypeId:carTypeId withTravelNum:travelNum withIsInsurance:isInsurance] map:^id(ResponseBaseData *data) {
        self.cPrice = [CalcPrice mj_objectWithKeyValues:data.result_data];
        return self.cPrice;
    }];
    return signal;
}

-(RACSignal *)addOrder{
    
    RACSignal *signal = [[[RequestBaseAPI standardAPI] addOrderWithOrder:self.order] map:^id(ResponseBaseData *responseData) {
        
        NSData *data = [responseData.result_data dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary *params = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        return params;

    }];
    
    return signal;
}


-(RACSignal *)getUserOrderList:(NSInteger)state{
    
    NSString *userID = [ZUserModel shareUserModel].userId;
    RACSignal *signal = [[[RequestBaseAPI standardAPI] getUserOrderList:[userID integerValue] wihtState:state  withPageIndex:self.pages.integerValue withPageSize:10] map:^id(ResponseBaseData *data) {
        
        self.orderList = [OrderListModel mj_objectArrayWithKeyValuesArray:data.result_data];
        return self.orderList;
    }];
    
    return signal;
}
-(RACSignal *)getUserOrderDetail:(NSString*)orderId
{
    
    RACSignal *signal = [[[RequestBaseAPI standardAPI] getUserOrderDetailOrderId:orderId] map:^id(ResponseBaseData *data) {
        
         self.orderList = @[[OrderListModel mj_objectWithKeyValues:data.result_data]];
        return self.orderList;
    }];
    
    return signal;
}

-(RACSignal *)notifyUrlWithOrderNo:(NSString *)orderNo withTotalMoney:(NSString *)money{
    
    RACSignal *signal = [[[RequestBaseAPI standardAPI] notifyUrlWithOutTradeNo:orderNo withTotalFee:money] map:^id(ResponseBaseData *data) {
        
        return data;
    }];
    
    return signal;
}

-(RACSignal *)cancelOrderWithOrderNo:(NSString *)orderNo{
    RACSignal *signal = [[[RequestBaseAPI standardAPI] cancelOrderWithOrderNo:orderNo] map:^id(ResponseBaseData *data) {
        return data;
    }];
    return signal;
}

-(RACSignal *)deleteOrder:(NSString *)orderId{
    RACSignal *signal = [[[RequestBaseAPI standardAPI] removeOrder:orderId] map:^id(ResponseBaseData *data) {
        
        return data;
    }];
    
    return signal;
}
@end
