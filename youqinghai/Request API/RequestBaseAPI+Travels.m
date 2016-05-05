//
//  RequestBaseAPI+Travels.m
//  youqinghai
//
//  Created by 舒永超 on 16/5/5.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "RequestBaseAPI+Travels.h"

// 发表游记
NSString *const publishTravels = @"app/operation/publishTravels";

@implementation RequestBaseAPI (Travels)

-(RACSignal *)publishTravelsWithContent:(NSString *)content withFiles:(NSArray *)files{
    
    NSMutableDictionary *dic = @[].mutableCopy;
    
    dic[@"userId"] = @([ZUserModel shareUserModel].userId.integerValue);
    dic[@"content"] = content;
    
    return [self ZpostApiString:publishTravels params:dic attachKey:@"fileName" attachData:files];
}

@end
