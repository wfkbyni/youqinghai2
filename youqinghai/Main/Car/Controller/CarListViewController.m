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

#import "CarViewModel.h"

@interface CarListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong) CarTypeTableView *carTypeTableView;

@property (nonatomic, strong) CarViewModel *carViewModel;

@end

#define identifier @"cell"

@implementation CarListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"我要包车";
    
    self.carViewModel = [[CarViewModel alloc] init];
    
    [self commonView];
    [self loadCarListData];
    [self loadCarTypeListData];
    
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
        [weakSelf loadCarListData];
    }];
    
    [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([CarListCell class]) bundle:nil] forCellReuseIdentifier:identifier];
    self.myTableView.tableFooterView = [[UIView alloc] init];
}

- (void)loadCarListData{
    self.carViewModel.tourId = self.recommend.Id;
    
    [RACObserve(self.carViewModel, cars) subscribeNext:^(id x) {
        [self.myTableView reloadData];
    }];
    
    [[self.carViewModel getCarList] subscribeError:^(NSError *error) {
        int code = [[error.userInfo objectForKey:@"result_code"] intValue];
        if (code == 1) {
            self.carViewModel.cars = @[];
            [self.myTableView reloadData];
        }
    } completed:^{
        
    }];
}

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
    controller.car = self.carViewModel.cars[indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
