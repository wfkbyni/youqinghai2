//
//  RequestBaseAPI+Pay.m
//  youqinghai
//
//  Created by 舒永超 on 16/5/3.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "RequestBaseAPI+Pay.h"

NSString *const payDemoActivity = @"alipay/payDemoActivity";    // 用户获取支付宝信息（1.0）
NSString *const payCreateOrder  = @"wxPay/createOrder";         // 获取微信支付信息（1.0）

@implementation RequestBaseAPI (Pay)

-(RACSignal *)getPayDemoActivityWithSubject:(NSString *)subject
                                   withBody:(NSString *)body
                                  withPrice:(NSString *)price
                             withOutTradeNo:(NSString *)outTradeNo{
    NSString *param = [NSString stringWithFormat:@"server=%@&subject=%@&body=%@&price=%@&outTradeNo=%@",payDemoActivity,subject,body,price,outTradeNo];
    return [self requestWithType:RequestAPITypePost params:[GTMBase64 desEncrypt:param]];
}

-(RACSignal *)getCreateOrderWithOutTradeNo:(NSString *)outTradeNo
                                  withBody:(NSString *)body
                              withTotalFee:(NSString *)totalFee{
    NSString *param = [NSString stringWithFormat:@"server=%@&outTradeNo=%@&body=%@&totalFee=%@",payCreateOrder,outTradeNo,body,totalFee];
    return [self requestWithType:RequestAPITypePost params:[GTMBase64 desEncrypt:param]];
}

@end
