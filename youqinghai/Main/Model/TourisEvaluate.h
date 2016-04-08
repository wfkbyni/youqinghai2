//
//  TourisEvaluate.h
//  youqinghai
//
//  Created by 舒永超 on 16/3/28.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "ResponseBaseData.h"

@class EvaluateImg;
@interface TourisEvaluate : ResponseBaseData

@property (nonatomic, strong) NSString *content;        // 评价内容
@property (nonatomic, assign) NSInteger Id;             // 评价Id
@property (nonatomic, strong) NSArray *listImage;       // 评论图片展示
@property (nonatomic, strong) NSString *userImgUrl;     // 用户头像
@property (nonatomic, strong) NSString *evatTime;       // 评论时间
@property (nonatomic, strong) NSString *userName;       // 用户名称

@end

@interface EvaluateImg : ResponseBaseData

@property (nonatomic, strong) NSString *imgUrl;         // 图片路径
@property (nonatomic, strong) NSString *imgId;          // 图片Id
@property (nonatomic, strong) NSString *eavId;          // 关联评论Id

@end
