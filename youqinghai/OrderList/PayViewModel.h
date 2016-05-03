//
//  PayViewModel.h
//  youqinghai
//
//  Created by 舒永超 on 16/5/3.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayViewModel : NSObject
/**
 *  @brief 用户获取支付宝信息（1.0）
 *
 */
- (RACSignal *)getPayDemoActivityWithSubject:(NSString *)subject
                                    withBody:(NSString *)body
                                   withPrice:(NSString *)price
                              withOutTradeNo:(NSString *)outTradeNo;

/**
 *  @brief 获取微信支付信息（1.0）
 *
 */
- (RACSignal *)getCreateOrderWithOutTradeNo:(NSString *)outTradeNo
                                   withBody:(NSString *)body
                               withTotalFee:(NSString *)totalFee;
@end
