//
//  VODBCache.m
//  VODBCacheDemo
//
//  Created by Valo on 15/7/31.
//  Copyright (c) 2015年 Valo. All rights reserved.
//

#import "VODBCache.h"
static VODBCache *_sharedCache;

@interface VODBCache ()
@property (nonatomic, copy  ) NSString         *dbPath;   /**< 数据库文件路径 */

@end

@implementation VODBCache
+ (instancetype)sharedCache{
    @synchronized(self){
        if (!_sharedCache) {
            _sharedCache = [[super allocWithZone:NULL] init];
        }
    }
    return _sharedCache;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    return [self sharedCache];
}

+ (id)copyWithZone:(struct _NSZone *)zone{
    return [self sharedCache];
}

- (NSString *)dbPath{
    @synchronized(self){
        if (!_dbPath) {
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
            NSString *cacheDir  = paths[0];
            _dbPath    = [cacheDir stringByAppendingPathComponent:@"vodbcache.sqlite"] ;
        }
    }
    return _dbPath;
}

- (FMDatabaseQueue *)cacheQueue{
    @synchronized(self){
        if (!_cacheQueue) {
            _cacheQueue = [FMDatabaseQueue databaseQueueWithPath:self.dbPath];
        }
    }
    return _cacheQueue;
}

- (void)clearCacheOnCompletion:(void (^)())completion{
    [self clearCacheIgnore:nil completion:completion];
}

- (void)clearCacheIgnore:(NSArray *)ignoreTableNames completion:(void (^)())completion{
    [self.cacheQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        // 1. 查询所有表名
        NSString *sql =@"select name from sqlite_master where type='table' order by name;";
        FMResultSet *rs = [db executeQuery:sql];
        NSMutableArray *tables = @[].mutableCopy;
        while ([rs next]) {
            NSString *tableName = [rs stringForColumnIndex:0];
            if (tableName) {
                [tables addObject:tableName];
            }
        }
        if (ignoreTableNames) {
            [tables removeObjectsInArray:ignoreTableNames];
        }
        [tables removeObject:@"sqlite_sequence"];
        [tables enumerateObjectsUsingBlock:^(NSString *table, NSUInteger idx, BOOL * stop) {
            NSString *sql = [NSString stringWithFormat:@"delete from '%@'",table];
            [db executeUpdate:sql];
        }];
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion();
            });
        }
    }];
    
}

- (NSUInteger)dbCacheSize{
    //1.数据库文件大小
    NSError *error = nil;
    NSDictionary *dbFileAttrs = [[NSFileManager defaultManager] attributesOfItemAtPath:self.dbPath error:&error];
    return  (error)? 0: (NSUInteger)dbFileAttrs.fileSize;
}


@end
