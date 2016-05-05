//
//  TravelsViewModel.h
//  youqinghai
//
//  Created by 舒永超 on 16/5/5.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TravelsViewModel : NSObject

/**
 *  @brief 发表游记（1.0）
 *
 *  @param userId  用户Id
 *  @param content 游记内容
 *  @param files   游记图片
 *
 */
- (RACSignal *)publishTravelsWithContent:(NSString *)content withFiles:(NSArray *)files;

/**
 *  @brief 评论游记（1.0）
 *
 *  @param travelId   游记Id
 *  @param comContent 评论内容
 *
 */
- (RACSignal *)commentTravelsWithTravelId:(NSInteger)travelId withComContent:(NSString *)comContent;

@end
