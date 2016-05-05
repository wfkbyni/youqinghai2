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
// 评论游记（1.0）
NSString *const commentTravels = @"app/operation/commentTravels";

@implementation RequestBaseAPI (Travels)

-(RACSignal *)publishTravelsWithContent:(NSString *)content withFiles:(NSArray *)files{
    
    NSMutableDictionary *dic = @{}.mutableCopy;
    
    NSString *userId = [ZUserModel shareUserModel].userId;
    dic[@"userId"] = userId;
    dic[@"content"] = content;
    
    return [self ZpostApiString:publishTravels params:dic attachKey:@"fileName" attachData:files];
}

-(RACSignal *)commentTravelsWithTravelId:(NSInteger)travelId withComContent:(NSString *)comContent{
    
    NSString *userId = [ZUserModel shareUserModel].userId;
    
    NSString *params = [NSString stringWithFormat:@"server=%@&travelId=%@&userId=%@&comContent=%@",commentTravels,@(travelId),userId,comContent];
    
    return [self requestWithType:RequestAPITypePost params:params];
}

@end
