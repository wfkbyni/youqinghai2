//
//  ZRouteFTableView.m
//  youqinghai
//
//  Created by snailz on 16/4/7.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "ZRouteFTableView.h"
#import "ZRouteFCell.h"
#import "RequestBaseAPI+Personal.h"
@interface ZRouteFTableView ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *tabAr;
@property(copy,nonatomic)NSString *pages;
@end
@implementation ZRouteFTableView
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate =self;
        self.dataSource = self;
        self.separatorStyle = 0;
        [self registerNib:[UINib nibWithNibName:@"ZRouteFCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ZRouteFCell"];
       // [self getNet];
        
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
    
    RACSignal *signal = [[RequestBaseAPI standardAPI]userRouteWithPageIndex:self.pages withPageSize:@"20"];
    __weak ZRouteFTableView *blockSelf= self;
    [signal subscribeNext:^(id x) {
        [blockSelf.mj_header endRefreshing];
        [blockSelf.mj_footer endRefreshing];
        NSArray *ar =  [NSJSONSerialization JSONObjectWithData:[((NSString *)x) dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        
        
        if (blockSelf.pages.integerValue!=1) {
            if (ar.count) {
                [blockSelf.tabAr addObjectsFromArray:[ZRouModel mj_objectArrayWithKeyValuesArray:ar]];
                [blockSelf reloadData];
            }else{
                 [self.mj_footer endRefreshingWithNoMoreData];
            }
           
            return ;
        }
        
        
        blockSelf.tabAr = [ZRouModel mj_objectArrayWithKeyValuesArray:ar];
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
    ZRouteFCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZRouteFCell"];
    cell.rouModel = self.tabAr[indexPath.section];
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
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        return 145;
   
}
@end
