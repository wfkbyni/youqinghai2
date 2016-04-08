//
//  ResopnseBaseData.h
//  youqinghai
//
//  Created by 舒永超 on 16/3/20.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResponseBaseData : NSObject

@property (nonatomic, strong) NSString *message;
@property (nonatomic, assign) NSInteger result_code;
@property (nonatomic, strong) NSString *result_data;

@end
