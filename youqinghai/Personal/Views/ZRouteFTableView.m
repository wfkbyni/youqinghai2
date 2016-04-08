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
        [self getNet];
    }
    return self;
}
-(void)getNet
{
    RACSignal *signal = [[RequestBaseAPI standardAPI]userRouteWithPageIndex:@"1" withPageSize:@"20"];
    __weak ZRouteFTableView *blockSelf= self;
    [signal subscribeNext:^(id x) {
        NSArray *ar =  [NSJSONSerialization JSONObjectWithData:[((NSString *)x) dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        self.tabAr = [ZRouModel mj_objectArrayWithKeyValuesArray:ar];
        NSLog(@"%@",self.tabAr );
        [blockSelf reloadData];
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
