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

/**
 *  @brief 评论游记（1.0）
 *
 *  @param travelId   游记Id
 *  @param comContent 评论内容
 *
 */
- (RACSignal *)commentTravelsWithTravelId:(NSInteger)travelId withComContent:(NSString *)comContent{
    return [[RequestBaseAPI standardAPI] commentTravelsWithTravelId:travelId withComContent:comContent];
}


@end
