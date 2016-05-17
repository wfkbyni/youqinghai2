//
//  ZTravelFTableView.m
//  youqinghai
//
//  Created by snailz on 16/4/7.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "ZTravelFTableView.h"
#import "RequestBaseAPI+Personal.h"
#import "ZTravelFCell.h"
@interface ZTravelFTableView ()<UITableViewDataSource,UITableViewDelegate>

@property(copy,nonatomic)NSString *pages;
@end
@implementation ZTravelFTableView
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate =self;
        self.dataSource = self;

        [self registerNib:[UINib nibWithNibName:@"ZTravelFCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ZTravelFCell"];
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
    RACSignal *signal = [[RequestBaseAPI standardAPI]userTravelsListWithPageIndex:@"1" withPageSize:@"20"];
    __weak ZTravelFTableView *blockSelf= self;
    [signal subscribeNext:^(id x) {
        [blockSelf.mj_header endRefreshing];
        [blockSelf.mj_footer endRefreshing];
        NSArray *ar =  [NSJSONSerialization JSONObjectWithData:[((NSString *)x) dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        if (blockSelf.pages.integerValue!=1) {
            if (ar.count) {
                [blockSelf.tabAr addObjectsFromArray:[ZTravelModel mj_objectArrayWithKeyValuesArray:ar]];
                [blockSelf reloadData];
            }else{
                [blockSelf.mj_footer endRefreshingWithNoMoreData];
            }
            
            return ;
        }
        
        
        blockSelf.tabAr = [ZTravelModel mj_objectArrayWithKeyValuesArray:ar];
        NSLog(@"%@",blockSelf.tabAr );
        [blockSelf reloadData];
      
    }];
    [signal subscribeError:^(NSError *error) {
        [blockSelf.mj_header endRefreshing];
        [blockSelf.mj_footer endRefreshing];
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tabAr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZTravelFCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZTravelFCell"];
    cell.travelMod = self.tabAr[indexPath.section];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 12;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.selectBlock) {
        self.selectBlock(indexPath)
        ;    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZTravelModel *mo = self.tabAr[indexPath.section];
    NSLog(@"%@",mo.height);
    return mo.height.integerValue;
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    // 下面这几行代码是用来设置cell的上下行线的位置
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 20, 0, 20)];
    }
}
@end
