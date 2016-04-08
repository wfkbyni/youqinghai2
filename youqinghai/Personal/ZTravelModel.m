//
//  ZTravelModel.m
//  youqinghai
//
//  Created by snailz on 16/4/7.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "ZTravelModel.h"

@implementation ZTravelModel
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
-(void)setContent:(NSString *)content
{
    _content =content;
    UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, [UIScreen mainScreen].bounds.size.width-24, 50)];
    text.numberOfLines = 3;
    text.font = [UIFont systemFontOfSize:15];
    text.text = content;
    [text sizeToFit];
    _height = @(text.frame.size.height+273).stringValue;
}
@end
