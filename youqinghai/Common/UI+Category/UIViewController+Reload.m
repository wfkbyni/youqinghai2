//
//  UIViewController+Reload.m
//  XCFClient
//
//  Created by mouxiaochun on 15/6/25.
//  Copyright (c) 2015年 mouxiaochun. All rights reserved.
//

#import "UIViewController+Reload.h"
#import "UIViewController+TableView.h"
#import "SRRefreshView.h"


#import <objc/runtime.h>


static NSString * key_SRRefreshView = @"key_SRRefreshView";
static NSString * key_DisplayRefresher = @"key_DisplayRefresher";
static NSString * key_StatusRefresher = @"key_StatusRefresher";
static NSString * key_SRMoreRefresh = @"key_SRMoreRefresh";


 


@implementation UIViewController(Reload)


#pragma mark -- setter && getter
-(id)delegate{
    
    return self;
}
- (SRRefreshView *)slimeView
{
    if ([self loadNewDataBlock]) {
        SRRefreshView *_slimeView = [self getSRRefresher];
        if (_slimeView == nil) {
            _slimeView = [[SRRefreshView alloc] init];
            _slimeView.delegate = self.delegate;
            _slimeView.upInset = 0;
            _slimeView.slimeMissWhenGoingBack = YES;
            _slimeView.slime.bodyColor = [UIColor grayColor];
            _slimeView.slime.skinColor = [UIColor grayColor];
            _slimeView.slime.lineWith = 1;
            _slimeView.slime.shadowBlur = 4;
            _slimeView.slime.shadowColor = [UIColor grayColor];
            objc_setAssociatedObject(self, (__bridge const void *)(key_SRRefreshView), _slimeView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        
        return _slimeView;
        
    }
    return nil;
}


-(SRRefreshView *)getSRRefresher{
    SRRefreshView *refresher =  objc_getAssociatedObject(self, (__bridge const void *)(key_SRRefreshView));
    return refresher;
}

-(void)setLoadNewDataBlock:(void (^)(void))block{
    objc_setAssociatedObject(self, &key_DisplayRefresher, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self.tableView addSubview:self.slimeView];

}
-(void (^) (void)) loadNewDataBlock{
    return objc_getAssociatedObject(self, &key_DisplayRefresher);
}

-(void)setLoadMoreDataBlock:(void (^)(void))block{
    objc_setAssociatedObject(self, &key_SRMoreRefresh, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self.tableView addSubview:self.slimeView];
    
}
-(void (^) (void)) loadMoreDataBlock{
    return objc_getAssociatedObject(self, &key_SRMoreRefresh);
}

-(void)setLoadStatus:(LoadDatasourceStatus)status{

  //  [self.tableView setLoadStatus:status];
    objc_setAssociatedObject(self, (__bridge const void *)(key_StatusRefresher), [NSNumber numberWithInt:status], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(LoadDatasourceStatus)loadStatus{
    NSNumber *style = objc_getAssociatedObject(self, (__bridge const void *)(key_StatusRefresher));
    return [style intValue];
}

#pragma mark ---

-(void)endRefresh{

    [self.slimeView endRefresh];
}
#pragma mark - scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.slimeView scrollViewDidScroll];
    if (scrollView.isDragging && !self.slimeView.loading) {
        if (scrollView.contentSize.height > self.view.height &&
            scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.height &&
            self.loadStatus != LoadDatasourceStatusMore &&
            self.loadStatus != LoadDatasourceStatusIng &&
            self.loadStatus != LoadDatasourceStatusNoNextPage) {
            if (self.loadMoreDataBlock) {
                self.loadMoreDataBlock();
            }
         }
    }

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.slimeView scrollViewDidEndDraging];
}
- (void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView
{
    if (self.loadNewDataBlock) {
        self.loadNewDataBlock();
    }
}

@end
