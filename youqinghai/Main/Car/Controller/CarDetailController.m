//
//  CarDetailController.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/31.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "CarDetailController.h"
#import "CarViewModel.h"

#import "DriverCarHeaderView.h"
#import "DriverCarPivViewTableViewCell.h"
#import "DriverCarCommentTableViewCell.h"
#import "DriverCarIntroduceTableViewCell.h"

#import "ConfirmOrderController.h"

@interface CarDetailController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) CarViewModel *carViewModel;

@property (nonatomic, strong) UITableView *myTableView;

@property (nonatomic, strong) DriverCarHeaderView *driverCarHeaderView;

@end

#define DriverCarPivViewCell @"DriverCarPivViewCell"
#define DriverCarCommentViewCell @"DriverCarCommentViewCell"
#define DriverCarIntroduceCell @"DriverCarIntroduceTableViewCell"

@implementation CarDetailController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self requestData];
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height - 60)];
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    [self.view addSubview:_myTableView];
    
    [_myTableView registerClass:[DriverCarPivViewTableViewCell class] forCellReuseIdentifier:DriverCarPivViewCell];
    [_myTableView registerClass:[DriverCarCommentTableViewCell class] forCellReuseIdentifier:DriverCarCommentViewCell];
    [_myTableView registerClass:[DriverCarIntroduceTableViewCell class] forCellReuseIdentifier:DriverCarIntroduceCell];
    
    [_myTableView setTableHeaderView:[self commonView]];
    
    UIButton *charteredBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, kScreenSize.height - 60, kScreenSize.width, 60)];
    [charteredBtn setBackgroundColor:[UIColor orangeColor]];
    [charteredBtn setTitle:@"立即包车" forState:UIControlStateNormal];
    [charteredBtn addTarget:self action:@selector(charteredAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:charteredBtn];
}

- (void)charteredAction:(id)sender{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"提示" message:@"您确定要包该车吗?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:NULL];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ConfirmOrderController *controller = [[ConfirmOrderController alloc] init];
        controller.traveId = 1;
        controller.carTypeId = 1;
        [self.navigationController pushViewController:controller animated:YES];
    }];
    
    [controller addAction:cancelAction];
    [controller addAction:defaultAction];
    
    [self presentViewController:controller animated:YES completion:NULL];
}

- (void)requestData{
    _carViewModel = [[CarViewModel alloc] init];
    _carViewModel.driverId = self.car.Id;
    [[_carViewModel getDriverCarDetails] subscribeError:^(NSError *error) {
        
    } completed:^{
        
    }];
    
    [RACObserve(self.carViewModel, carDetail) subscribeNext:^(CarDetail *carDetail) {
        if (carDetail) {
            [_driverCarHeaderView bindData:carDetail];
            
            [self.myTableView reloadData];
        }
    }];
}

- (UIView *)commonView{
    if (!_driverCarHeaderView) {
        _driverCarHeaderView = [[DriverCarHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 250)];
        [self.view addSubview:_driverCarHeaderView];
        
        @weakify(self)
        [_driverCarHeaderView setBtnClickEvent:^(BtnClickEvent event) {
            @strongify(self)
            switch (event) {
                case BtnClickEventWithBack: {
                    [self.navigationController popViewControllerAnimated:YES];
                    break;
                }
                case BtnClickEventWithCollection: {
                    
                    break;
                }
            }
        }];
    }
    
    return _driverCarHeaderView;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 170.0f;
            break;
        case 1:
            return 140.0f * 3 + 90;
            break;
        case 2:
        {
            float height = [self.carViewModel.carDetail.driverInfo calHeightWithWidth:kScreenSize.width - 20 withFontSize:14];
            return height + 50;
        }
            break;
        default:
            break;
    }
    
    return 170.0f;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            DriverCarPivViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DriverCarPivViewCell];
            if (!cell) {
                cell = [[DriverCarPivViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DriverCarPivViewCell];
            }
            cell.imgList = _carViewModel.carDetail.imgList;
            return cell;
        }
            break;
        case 1:
        {
            DriverCarCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DriverCarCommentViewCell];
            if (!cell) {
                cell = [[DriverCarCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DriverCarCommentViewCell];
            }
            
            cell.evalist = _carViewModel.carDetail.evalist;
            
            return cell;
        }
            break;
        case 2:
        {
            DriverCarIntroduceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DriverCarIntroduceCell];
            if (!cell) {
                cell = [[DriverCarIntroduceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DriverCarIntroduceCell];
            }
            
            cell.driverInfo = self.carViewModel.carDetail.driverInfo;
            
            return cell;
        }
            break;
        default:
            break;
    }
    
    DriverCarPivViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DriverCarPivViewCell];
    if (!cell) {
        cell = [[DriverCarPivViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DriverCarPivViewCell];
    }
    
    return cell;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat yOffset = scrollView.contentOffset.y  ;
    
    if (yOffset < 0) {
        CGFloat totalOffset = 250 + ABS(yOffset);
        CGFloat f = totalOffset / 250;
        
        _driverCarHeaderView.bgImageView.frame = CGRectMake(- (width * f - width) / 2, yOffset, width * f, totalOffset);
    }
}
@end
