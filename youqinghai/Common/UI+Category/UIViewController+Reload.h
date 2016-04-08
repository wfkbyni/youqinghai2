//
//  UIViewController+Reload.h
//  XCFClient
//
//  Created by mouxiaochun on 15/6/25.
//  Copyright (c) 2015年 mouxiaochun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRDefine.h"

typedef enum LoadDatasourceStatus{
    LoadDatasourceStatusNone = 0, //正常数据
    LoadDatasourceStatusIng,    //正在加载
    LoadDatasourceStatusNoResult, //数据为空
    LoadDatasourceStatusMore,//正在加载下一页
    LoadDatasourceStatusNoNextPage //没有更多数据,不需要加载下一页
}LoadDatasourceStatus;

@interface UIViewController(Reload)
/**
 *  显示下拉刷新控件
 */
@property(copy, nonatomic) void(^loadNewDataBlock)(void);

@property(copy, nonatomic) void(^loadMoreDataBlock)(void);

-(void)endRefresh;

-(void)setLoadStatus:(LoadDatasourceStatus)status;

-(LoadDatasourceStatus)loadStatus;

@end
