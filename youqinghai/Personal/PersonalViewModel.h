//
//  PersonalViewModel.h
//  youqinghai
//
//  Created by snailz on 16/3/28.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonalViewModel : NSObject
@property (nonatomic, assign) NSString* page;
/**
 *  获取消息中心数据
 *
 *  @return <#return value description#>
 */
-(RACSignal*)getMessData;
@end
