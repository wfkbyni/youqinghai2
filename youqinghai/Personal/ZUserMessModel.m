//
//  ZUserMessModel.m
//  youqinghai
//
//  Created by snailz on 16/4/6.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "ZUserMessModel.h"

@implementation ZUserMessModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    
    return @{@"ID":@"id"};
}
-(void)setAddTime:(NSString *)addTime
{
    NSDate *date= [NSDate dateWithTimeIntervalSince1970:(addTime.integerValue)/1000];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"y-M-d HH:mm"];
    _addTime = [dateFormatter stringFromDate:date];
}
@end
