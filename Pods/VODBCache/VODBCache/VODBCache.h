//
//  VODBCache.h
//  VODBCacheDemo
//
//  Created by Valo on 15/7/31.
//  Copyright (c) 2015年 Valo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface VODBCache : NSObject

@property (nonatomic, strong) FMDatabaseQueue *cacheQueue;

@property (nonatomic, assign) BOOL logsErrors; /**< 是否打印错误日志 */
/**
 *  共享缓存,单例对象
 *
 *  @return 单例对象
 */
+ (instancetype)sharedCache;

/**
 *  清除缓存
 *
 *  @param completion 清除缓存完成后的操作
 */
- (void)clearCacheOnCompletion:(void (^)())completion;

/**
 *  清除缓存
 *
 *  @param ignoreTableNames 不清除数据的表名
 *  @param completion       清除缓存完成后的操作
 */
- (void)clearCacheIgnore:(NSArray *)ignoreTableNames
              completion:(void (^)())completion;

/**
 *  获取缓存大小
 *
 *  @return 缓存数据大小
 */
- (NSUInteger)dbCacheSize;

@end
