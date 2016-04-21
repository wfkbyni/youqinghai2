//
//  ZDriverController.m
//  youqinghai
//
//  Created by snailz on 16/4/7.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "ZDriverFTableView.h"

#import "RequestBaseAPI+Personal.h"
@interface ZDriverFTableView ()<UITableViewDataSource,UITableViewDelegate>

@property(copy,nonatomic)NSString *pages;
@end
@implementation ZDriverFTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate =self;
        self.dataSource = self;
        
        [self registerNib:[UINib nibWithNibName:@"ZDriverCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ZDriverCell"];
        MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
        self.mj_header = header;
        
        
            self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                self.pages = @(self.pages.integerValue+1).stringValue;
                [self getNet];
            }];
       
        self.mj_footer.hidden=YES;
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
    RACSignal *signal = [[RequestBaseAPI standardAPI]userDriverListWithPageIndex:self.pages withPageSize:@"20"];
    __weak ZDriverFTableView *blockSelf= self;
    [signal subscribeNext:^(id x) {
        self.mj_footer.hidden=NO;
        [blockSelf.mj_header endRefreshing];
        [blockSelf.mj_footer endRefreshing];
        NSArray *ar =  [NSJSONSerialization JSONObjectWithData:[((NSString *)x) dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        if (blockSelf.pages.integerValue!=1) {
            if (ar.count) {
                [blockSelf.tabAr addObjectsFromArray:[ZDriverModel mj_objectArrayWithKeyValuesArray:ar]];
                [blockSelf reloadData];
            }else{
                [blockSelf.mj_footer endRefreshingWithNoMoreData];
            }
            
            return ;
        }
        
        if (ar.count<20) {
              [blockSelf.mj_footer endRefreshingWithNoMoreData];
        }
        blockSelf.tabAr = [ZDriverModel mj_objectArrayWithKeyValuesArray:ar];
        NSLog(@"%@",blockSelf.tabAr );
        [blockSelf reloadData];
 
    }];
    [signal subscribeError:^(NSError *error) {
        self.mj_footer.hidden=NO;
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
    ZDriverCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZDriverCell"];
    cell.driverMod = self.tabAr[indexPath.row];
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
    if (self.selectBlock) {
        self.selectBlock(indexPath)
        ;    }
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
