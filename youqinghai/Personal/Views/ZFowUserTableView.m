//
//  ZFowUserTableView.m
//  youqinghai
//
//  Created by snailz on 16/4/8.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "ZFowUserTableView.h"
#import "ZFowUserCell.h"
#import "RequestBaseAPI+Personal.h"
@interface ZFowUserTableView ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *tabAr;
@property(copy,nonatomic)NSString *pages;
@end
@implementation ZFowUserTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate =self;
        self.dataSource = self;
        
        [self registerNib:[UINib nibWithNibName:@"ZFowUserCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ZFowUserCell"];
        MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
        self.mj_header = header;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                self.pages = @(self.pages.integerValue+1).stringValue;
                [self getNet];
            }];
        });
        
        [self.mj_header beginRefreshing];
        
    }
    return self;
}
-(void)headerRefresh
{
    self.pages = @"1";
    [self getNet];
}
-(void)getNet
{
    RACSignal *signal = [[RequestBaseAPI standardAPI]userFollowUserListWithPageIndex:self.pages withPageSize:@"20"];
    __weak ZFowUserTableView *blockSelf= self;
    [signal subscribeNext:^(id x) {
        [blockSelf.mj_header endRefreshing];
        [blockSelf.mj_footer endRefreshing];
        NSArray *ar =  [NSJSONSerialization JSONObjectWithData:[((NSString *)x) dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        if (blockSelf.pages.integerValue!=1) {
            if (ar.count) {
                [blockSelf.tabAr addObjectsFromArray:[ZFowUserModel mj_objectArrayWithKeyValuesArray:ar]];
                [blockSelf reloadData];
            }else{
                [blockSelf.mj_footer endRefreshingWithNoMoreData];
            }
            
            return ;
        }
        
        
        blockSelf.tabAr = [ZFowUserModel mj_objectArrayWithKeyValuesArray:ar];
        NSLog(@"%@",blockSelf.tabAr );
        [blockSelf reloadData];
 
    }];
    [signal subscribeError:^(NSError *error) {
        [blockSelf.mj_header endRefreshing];
        [blockSelf.mj_footer endRefreshing];
        [blockSelf.mj_footer endRefreshingWithNoMoreData];
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tabAr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZFowUserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZFowUserCell"];
    cell.userMod = self.tabAr[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 100;
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    // 下面这几行代码是用来设置cell的上下行线的位置
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 20, 0, 20)];
    }
}


@end
