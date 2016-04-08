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
@end
@implementation ZFowUserTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate =self;
        self.dataSource = self;
        
        [self registerNib:[UINib nibWithNibName:@"ZFowUserCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ZFowUserCell"];
        [self getNet];
    }
    return self;
}
-(void)getNet
{
    RACSignal *signal = [[RequestBaseAPI standardAPI]userFollowUserListWithPageIndex:@"1" withPageSize:@"20"];
    __weak ZFowUserTableView *blockSelf= self;
    [signal subscribeNext:^(id x) {
        NSArray *ar =  [NSJSONSerialization JSONObjectWithData:[((NSString *)x) dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        self.tabAr = [ZFowUserModel mj_objectArrayWithKeyValuesArray:ar];
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
