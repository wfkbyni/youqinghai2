//
//  ZCustomListModel.m
//  youqinghai
//
//  Created by snailz on 16/4/7.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "ZCustomListModel.h"

@implementation ZCustomListModel

+ (NSDictionary *)replacedKeyFromPropertyName{
    
    return @{@"ID":@"id"};
}

-(void)setTravelTime:(NSString *)travelTime
{
    NSDate *date= [NSDate dateWithTimeIntervalSince1970:(travelTime.integerValue)/1000];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"y-M-d"];
    _travelTime = [dateFormatter stringFromDate:date];
}
-(void)setApplyTime:(NSString *)applyTime
{
    NSDate *date= [NSDate dateWithTimeIntervalSince1970:(applyTime.integerValue)/1000];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"y-M-d"];
    _applyTime = [dateFormatter stringFromDate:date];
}
@end
