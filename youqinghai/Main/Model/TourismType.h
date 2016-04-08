//
//  TourismType.h
//  youqinghai
//
//  Created by 舒永超 on 16/3/22.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @brief 线路类型
 */
@interface TourismType : NSObject

@property (nonatomic, assign) NSInteger Id;          //类型Id
@property (nonatomic, assign) NSInteger sort;        //排序
@property (nonatomic, strong) NSString *typeName;    //类型名称
@property (nonatomic, strong) NSString *typeImgUrl;  //图片路径"

@end
