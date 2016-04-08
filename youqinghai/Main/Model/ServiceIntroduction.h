//
//  ServiceIntroduction.h
//  youqinghai
//
//  Created by 舒永超 on 16/3/29.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "ResponseBaseData.h"

@interface ServiceIntroduction : ResponseBaseData

@property (nonatomic, strong) NSString *serviceInfo;

@end

@interface RoteCollection : ResponseBaseData

@property (nonatomic, assign) NSInteger state;
@property (nonatomic, assign) NSInteger collNum;

@end
