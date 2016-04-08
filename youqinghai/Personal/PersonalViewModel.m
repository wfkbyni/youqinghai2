//
//  PersonalViewModel.m
//  youqinghai
//
//  Created by snailz on 16/3/28.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "PersonalViewModel.h"
#import "RequestBaseAPI+Personal.h"
@implementation PersonalViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.page = @"1";
    }
    return self;
}
-(RACSignal *)getMessData
{
        RACSignal *signal =  [[RequestBaseAPI standardAPI] messDataWithPageIndex:self.page withPageSize:@"30"];
//        [signal subscribeNext:^(id x) {
//            
//        }];
    return signal;
}
@end
