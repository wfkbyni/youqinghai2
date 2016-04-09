//
//  OrderDetailViewController.m
//  youqinghai
//
//  Created by mouxiaochun on 16/4/8.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "UIViewController+TableView.h"
#import "OrderListDetailCell.h"
#import "YQHRadiusButton.h"
@interface OrderDetailViewController () {

}

@property (nonatomic, strong) NSMutableArray *datasourceOfTitles;
@property (nonatomic, strong) NSMutableArray *datasourceOfValues;


@end

@implementation OrderDetailViewController

- (instancetype)init{

    self = [super init];
    if (self) {
        
     }
    return self;
}

- (void)viewDidLoad {

    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:236.0/255.0 green:237.0/255.0 blue:238.0/255.0 alpha:1];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.title = @"订单详情";
    [self commonInit];
    
}


- (void)commonInit {
    _datasourceOfTitles = [NSMutableArray array];
    _datasourceOfValues = [NSMutableArray array];
    
    NSArray *titles1 = @[@"订单号",@"下单时间",@"订单状态"];
    NSArray *titles2 = @[@"出游路线",@"出游日期",@"出游人数",@"出游天数",@"车辆类型",@"订单金额",@"支付定金"];
    NSArray *titles3 = @[@"服务司机",@"服务车辆",@"联系人",@"联系电话",@"紧急联系人",@"紧急电话",@"是否购买保险"];
    [_datasourceOfTitles addObject:titles1];
    [_datasourceOfTitles addObject:titles2];
    [_datasourceOfTitles addObject:titles3];
    
    NSArray *values1 = @[@"12343543546546",@"2015-08-01 06:30",@"待付款"];
    NSArray *values2 = @[@"青海湖三日游",@"2016-01-01",@"3人",@"3天",@"经济型",@"￥1500",@"￥150"];
    NSArray *values3 = @[@"陆离",@"哈佛H6",@"海涛",@"18782901597",@"君恋",@"18782901597",@"否"];
    [_datasourceOfValues addObject:values1];
    [_datasourceOfValues addObject:values2];
    [_datasourceOfValues addObject:values3];
    
    
    
    self.tableView.tableFooterView = self.tableViewFooterView;
    [self.view addSubview:self.footerView];

}


#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _datasourceOfTitles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *list = _datasourceOfTitles[section];
    return list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static  NSString *identify = @"OrderListDetailCell";
    OrderListDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[OrderListDetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSArray *list = _datasourceOfTitles[indexPath.section];
    NSString *title = list[indexPath.row];
    NSArray *values = _datasourceOfValues[indexPath.section];
    NSString *value = values[indexPath.row];
    
    if ([title hasPrefix:@"订单金额"]||[title hasPrefix:@"支付定金"]) {
        cell.detailTextLabel.textColor = [UIColor redColor];
    }else{
        cell.detailTextLabel.textColor = [UIColor colorWithRed:3.0/255.0 green:3.0/255.0 blue:3.0/255.0 alpha:1.0f];
    }
    
    cell.textLabel.text = title;
    cell.detailTextLabel.text = value;
    return cell;
}


- (UIView *)footerView {

    UIView *lView = UIView.new;
    CGRect frame = self.view.frame;
    frame.size.height = 60;
    frame.origin.y = self.view.height - 60;
    lView.frame = frame;
    lView.backgroundColor = [UIColor whiteColor];
    
    
    UIColor *color = [UIColor redColor];
    
    YQHRadiusButton *confirmPayBt = [YQHRadiusButton createWithTitle:@"立即支付" withColor:color];
    
    [confirmPayBt setOrigin:CGPointMake(self.view.width - confirmPayBt.width-10,(lView.height - confirmPayBt.height)/2)];
    [lView addSubview:confirmPayBt];

    
     color = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1];
    
    YQHRadiusButton *cancelBt = [YQHRadiusButton createWithTitle:@"取消订单" withColor:color];
    
    [cancelBt setOrigin:CGPointMake(confirmPayBt.x-cancelBt.width - 5,confirmPayBt.y)];
    [lView addSubview:cancelBt];
    
    lView.layer.borderWidth = 0.5;
    lView.layer.masksToBounds = YES;
    lView.layer.borderColor = color.CGColor;
   
    return lView;
}


- (UIView *)tableViewFooterView {

    UIView *lView = UIView.new;
    CGRect frame = self.view.frame;
    frame.size.height = 60;
    lView.frame = frame;
    lView.backgroundColor = [UIColor clearColor];
    return lView;
}



@end
