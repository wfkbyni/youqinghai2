//
//  PayViewModel.m
//  youqinghai
//
//  Created by 舒永超 on 16/5/3.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "PayViewModel.h"
#import "RequestBaseAPI+Pay.h"
#import "PayInfo.h"

@implementation PayViewModel

-(RACSignal *)getPayDemoActivityWithSubject:(NSString *)subject withBody:(NSString *)body withPrice:(NSString *)price withOutTradeNo:(NSString *)outTradeNo{
    
    return [[[RequestBaseAPI standardAPI] getPayDemoActivityWithSubject:subject withBody:body withPrice:price withOutTradeNo:outTradeNo] map:^id(ResponseBaseData *value) {
        
        PayInfo *payInfo = [PayInfo mj_objectWithKeyValues:value.result_data];
        
        return payInfo;
    }];
}

-(RACSignal *)getCreateOrderWithOutTradeNo:(NSString *)outTradeNo withBody:(NSString *)body withTotalFee:(NSString *)totalFee{
    
    return [[[RequestBaseAPI standardAPI] getCreateOrderWithOutTradeNo:outTradeNo withBody:body withTotalFee:totalFee] map:^id(ResponseBaseData *value) {
        PayInfo *payInfo = [PayInfo mj_objectWithKeyValues:value.result_data];
        
        return payInfo;
    }];
}

@end
