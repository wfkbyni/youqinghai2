//
//  ZDriverController.m
//  youqinghai
//
//  Created by snailz on 16/4/7.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "ZDriverFTableView.h"
#import "ZDriverCell.h"
#import "RequestBaseAPI+Personal.h"
@interface ZDriverFTableView ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *tabAr;
@end
@implementation ZDriverFTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate =self;
        self.dataSource = self;
        
        [self registerNib:[UINib nibWithNibName:@"ZDriverCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ZDriverCell"];
        [self getNet];
    }
    return self;
}
-(void)getNet
{
    RACSignal *signal = [[RequestBaseAPI standardAPI]userDriverListWithPageIndex:@"1" withPageSize:@"20"];
    __weak ZDriverFTableView *blockSelf= self;
    [signal subscribeNext:^(id x) {
        NSArray *ar =  [NSJSONSerialization JSONObjectWithData:[((NSString *)x) dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        self.tabAr = [ZDriverModel mj_objectArrayWithKeyValuesArray:ar];
        NSLog(@"%@",self.tabAr );
        [blockSelf reloadData];
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
