//
//  CarDetail.h
//  youqinghai
//
//  Created by 舒永超 on 16/3/31.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "ResponseBaseData.h"

@interface CarDetail : ResponseBaseData
@property (nonatomic, assign) NSInteger seatsnum;       // 座位数,
@property (nonatomic, assign) NSInteger driveage;       // 驾龄,
@property (nonatomic, assign) NSInteger sernum;         // 服务次数,
@property (nonatomic, assign) NSInteger isCollection;   // 0：未收藏 1：已收藏

@property (nonatomic, strong) NSString *cartypename;    // 车辆类型
@property (nonatomic, strong) NSString *nickname;       // 司机名称
@property (nonatomic, assign) NSInteger driverId;       // 司机Id,
@property (nonatomic, assign) NSInteger eav;            // 评价百分比,
@property (nonatomic, assign) NSInteger sex;            // 性别
@property (nonatomic, strong) NSString *carname;        // 车辆名称
@property (nonatomic, strong) NSString *driverInfo;     // 司机服务介绍",
@property (nonatomic, strong) NSString *headUrl;        // "司机头像路径",
@property (nonatomic, strong) NSArray *evalist;         // 对司机的评论列表
@property (nonatomic, strong) NSArray *imgList;         // 司机车辆图片展示
@end

@interface Eav : ResponseBaseData

@property (nonatomic, strong) NSString *content;        // 评论内容",
@property (nonatomic, assign) NSInteger Id;             // 评论Id,
@property (nonatomic, strong) NSString *nickname;       // 评论用户昵称",
@property (nonatomic, strong) NSString *evatTime;       // 评论时间
@property (nonatomic, assign) NSInteger driverId;       // 司机Id,
@property (nonatomic, strong) NSString *headUrl;        // 用户头像路径
@property (nonatomic, assign) NSInteger eavscore;       // 评论分数

@end

@interface Img : ResponseBaseData
@property (nonatomic, assign) NSInteger Id;             // 图片Id,
@property (nonatomic, strong) NSString *imgUrl;       // 图片路径"
@end
