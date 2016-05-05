//
//  TravelsViewModel.m
//  youqinghai
//
//  Created by 舒永超 on 16/5/5.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "TravelsViewModel.h"
#import "RequestBaseAPI+Travels.h"

@implementation TravelsViewModel

/**
 *  @brief 发表游记（1.0）
 *
 *  @param userId  用户Id
 *  @param content 游记内容
 *  @param files   游记图片
 *
 */
- (RACSignal *)publishTravelsWithContent:(NSString *)content withFiles:(NSArray *)files{
    RACSignal *signal = [[[RequestBaseAPI standardAPI] publishTravelsWithContent:content withFiles:files] map:^id(id value) {
        
        return value;
    }];
    
    return signal;
}

@end
