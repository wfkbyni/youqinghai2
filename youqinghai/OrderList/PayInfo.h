//
//  PayInfo.h
//  youqinghai
//
//  Created by 舒永超 on 16/5/3.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayInfo : NSObject

@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) NSString *sign_type;
@property (nonatomic, strong) NSString *notify_url;
@property (nonatomic, strong) NSString *out_trade_no;
@property (nonatomic, strong) NSString *sign;
@property (nonatomic, strong) NSString *orderInfo;
@property (nonatomic, strong) NSString *_input_charset;
@property (nonatomic, strong) NSString *it_b_pay;
@property (nonatomic, strong) NSString *total_fee;
@property (nonatomic, strong) NSString *service;
@property (nonatomic, strong) NSString *partner;
@property (nonatomic, strong) NSString *seller_id;
@property (nonatomic, strong) NSString *payment_type;

@end