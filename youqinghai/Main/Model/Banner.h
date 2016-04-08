//
//  Banner.h
//  youqinghai
//
//  Created by 舒永超 on 16/3/22.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @brief 首页Banner
 */
@interface Banner : NSObject

@property (nonatomic, assign) NSInteger Id;         //Id
@property (nonatomic, strong) NSString *redirect;   //跳转地址
@property (nonatomic, strong) NSString *title;      //标题
@property (nonatomic, assign) NSInteger sort;       //排序
@property (nonatomic, strong) NSString *remarks;    //备注
@property (nonatomic, strong) NSString *imgUrl;     //banner图片路径
@property (nonatomic, strong) NSString *addTime;    //添加时间

@end
