//
//  OrderListModel.m
//  youqinghai
//
//  Created by snailz on 16/4/9.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "OrderListModel.h"

@implementation OrderListModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"Id":@"id"};
}
-(void)setSingletime:(NSString *)singletime
{
    NSDate *date= [NSDate dateWithTimeIntervalSince1970:(singletime.longLongValue)/1000];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"y-M-d HH:mm"];
    
    _singletime = [dateFormatter stringFromDate:date];
  
}
-(void)setTravelTime:(NSString *)travelTime
{
    NSDate *date= [NSDate dateWithTimeIntervalSince1970:(travelTime.longLongValue)/1000];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"y-M-d HH:mm"];
    _travelTime = [dateFormatter stringFromDate:date];

}
@end
