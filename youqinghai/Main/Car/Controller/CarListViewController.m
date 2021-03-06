//
//  CarListViewController.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/30.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "CarListViewController.h"
#import "CarDetailController.h"

#import "CarListCell.h"
#import "CustomMoveItemView.h"
#import "CarTypeTableView.h"
#import "StatisticsPlatformDataView.h"

#import "CarViewModel.h"

@interface CarListViewController (){
    long interval;
}

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong) CarTypeTableView *carTypeTableView;
@property (nonatomic, strong) StatisticsPlatformDataView *statisticsPlatformDataView;

@property (nonatomic, strong) UILabel *titleDate;

@property (nonatomic, strong) CarViewModel *carViewModel;

@end

#define identifier @"cell"

@implementation CarListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"我要包车";
    
    self.navigationItem.titleView = [self titleView];
    
    self.carViewModel = [[CarViewModel alloc] init];
    
    [self commonView];
    [self loadCarTypeListData];
    [self getStatisticsPlatformData];
    
    _myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.carViewModel.pageIndex = 1;
        [self loadCarListData];
    }];
    [_myTableView.mj_header beginRefreshing];
    
    _myTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.carViewModel.pageIndex ++;
        [self loadCarListData];
    }];
    
}

- (UIView *)titleView{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
    
    NSDate *date = [NSDate date];
    interval = [date timeIntervalSince1970];
    
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:interval];
    
    interval = interval * 1000;
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString *time1 = [df stringFromDate:date2];
    
    _titleDate = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 40)];
    [_titleDate setText:time1];
    [_titleDate setTextAlignment:NSTextAlignmentCenter];
    [_titleDate setTextColor:[UIColor whiteColor]];
    [_titleDate sizeToFit];
    [_titleDate setHeight:40];
    [titleView addSubview:_titleDate];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(_titleDate.relativeX, 6, 20, 30)];
    [button setImage:[UIImage imageNamed:@"arrow_down01"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(showDatePicker:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:button];
    
    return titleView;
}

- (void)commonView{
    __block NSInteger index = 0;
    NSArray *items = @[@"默认",@"评价 ↓",@"价格 ↓",@"车辆类型"];
    CustomMoveItemView *customMoveItemView = [[CustomMoveItemView alloc] initWithFrame:CGRectMake(0, 64, kScreenSize.width, 40) withItems:items]; // ↑
    @weakify(self)
    [customMoveItemView setCustoMoveItemBlock:^(TourismDetailType type, UILabel *lab) {
        @strongify(self)
        if (index == type) {
            if ([lab.text containsString:@"价格 ↓"]) {
                [lab setText:@"价格 ↑"];
                self.carViewModel.priceState = 1;
            }else if([lab.text containsString:@"价格 ↑"]){
                [lab setText:@"价格 ↓"];
                self.carViewModel.priceState = 0;
            }
            
            if ([lab.text containsString:@"评价 ↓"]) {
                [lab setText:@"评价 ↑"];
                self.carViewModel.eavnum = 1;
            }else if([lab.text containsString:@"评价 ↑"]){
                [lab setText:@"评价 ↓"];
                self.carViewModel.eavnum = 0;
            }
        }else if(index == items.count - 1){
            self.carTypeTableView.isAlpha = 1;
        }
        index = type;
        
        if (index != items.count - 1) {
            self.carTypeTableView.isAlpha = 0;
            // 默认
            if (type == TourismDetailTypeWithIntroduction) {
                self.carViewModel.cartypeId = 0;
            }
            
            [self loadCarListData];
        }else{
            self.carTypeTableView.isAlpha = 1;
        }
    }];
    [self.view addSubview:customMoveItemView];
    
    self.carTypeTableView = [[CarTypeTableView alloc] initWithFrame:CGRectZero];
    self.carTypeTableView.isAlpha = 0;
    [self.view addSubview:self.carTypeTableView];
    
    __weak typeof(CarListViewController *) weakSelf = self;
    [self.carTypeTableView setSelectCarType:^(CarType *carType) {
        weakSelf.carViewModel.cartypeId = carType.Id;
        customMoveItemView.carTypeLabel.text = carType.cartypename;
        [weakSelf loadCarListData];
    }];
    
    [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([CarListCell class]) bundle:nil] forCellReuseIdentifier:identifier];
    self.myTableView.tableFooterView = [[UIView alloc] init];
    
    _statisticsPlatformDataView = [[StatisticsPlatformDataView alloc] initWithFrame:CGRectMake(0, kScreenSize.height - 50, kScreenSize.width, 50)];
    [self.view addSubview:_statisticsPlatformDataView];
}

/**
 *  @brief 获取车辆列表数据
 */
- (void)loadCarListData{
    self.carViewModel.tourId = self.recommend.Id;
    
    @weakify(self)
    [RACObserve(self.carViewModel, cars) subscribeNext:^(id x) {
        @strongify(self)
        [self.myTableView reloadData];
    }];
    
    [[self.carViewModel getCarList] subscribeError:^(NSError *error) {
        @strongify(self)
        int code = [[error.userInfo objectForKey:@"result_code"] intValue];
        if (code == 1) {
            //self.carViewModel.cars = @[].mutableCopy;
            //[self.myTableView reloadData];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.carViewModel.pageIndex == 1) {
                    [self.carViewModel.cars removeAllObjects];
                    [self.myTableView reloadData];
                }
                [self.myTableView.mj_footer endRefreshingWithNoMoreData];
                [self.view makeToast:[error.userInfo objectForKey:@"message"]];
            });
        }
        
        [self.myTableView.mj_footer endRefreshing];
        [self.myTableView.mj_header endRefreshing];
    } completed:^{
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
    }];
}

/**
 *  @brief 获取平台统计数据
 */
- (void)getStatisticsPlatformData{
    [[self.carViewModel getStatisticsPlatformData] subscribeNext:^(ResponseBaseData *data) {
        
        self.statisticsPlatformDataView.statisticsPlatformData = data.result_data;
        
    } error:^(NSError *error) {
        [self.view makeToast:error.localizedDescription];
    } completed:^{
        
    }];
}

/**
 *  @brief 获取车辆类型数据
 */
- (void)loadCarTypeListData{
    [[self.carViewModel getCarTypeList] subscribeError:^(NSError *error) {
        
    } completed:^{
        
    }];
    
    [RACObserve(self.carViewModel, carTypes) subscribeNext:^(id x) {
        self.carTypeTableView.frame = CGRectMake(0, 40 + 64, kScreenSize.width, self.carViewModel.carTypes.count * 44);
        self.carTypeTableView.carTypes = self.carViewModel.carTypes;
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.carViewModel.cars.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CarListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.car = self.carViewModel.cars[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CarDetailController *controller = [[CarDetailController alloc] init];
    Car *car = self.carViewModel.cars[indexPath.row];
    car.travelTime = [NSString stringWithFormat:@"%ld",interval];
    controller.car = car;
    controller.paytitle = self.recommend.title;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)showDatePicker:(UIButton *)sender{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIDatePicker *picker = [[UIDatePicker alloc] init];
    picker.minuteInterval = 30;
    picker.minimumDate = [NSDate date];
    [picker setDatePickerMode:UIDatePickerModeDateAndTime];
    [alertController.view addSubview:picker];
    [alertController addAction:({
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSDateFormatter *form = [[NSDateFormatter alloc] init]; // 定义时间格式
            [form setDateFormat:@"yyyy-MM-dd"];
            NSString *dateString = [form stringFromDate:picker.date];
            
            self.titleDate.text = dateString;
            interval = [picker.date timeIntervalSince1970] * 1000;
            self.carViewModel.travelTime = interval;
            
            self.carViewModel.pageIndex = 1;
            [self loadCarListData];
            
        }];
        action;
    })];
    UIPopoverPresentationController *popoverController = alertController.popoverPresentationController;
    popoverController.sourceView = self.navigationController.visibleViewController.view;
    popoverController.sourceRect = [self.navigationController.visibleViewController.view bounds];
    [self.navigationController.visibleViewController presentViewController:alertController  animated:YES completion:nil];
}

@end
