//
//  TourismDetailController.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/25.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "TourismDetailController.h"

#import "CustomMoveItemView.h"
#import "TourismDetailView.h"
#import "TourisEvaluateView.h"
#import "ServiceIntroductionView.h"
#import "CarListViewController.h"

#import "MainViewModel.h"

@interface TourismDetailController (){
    BOOL isRequestTourismDetail;
    BOOL isRequestTourisEvaluate;
    BOOL isRequestServiceIntroduction;
}

@property (nonatomic, strong) MainViewModel *mainViewModel;

@property (nonatomic, strong) UIView *tableViewHeaderView;

@property (nonatomic, strong) TourismDetailView *tourismDetailView;
@property (nonatomic, strong) TourisEvaluateView *tourisEvaluateView;
@property (nonatomic, strong) ServiceIntroductionView *serviceIntroductionView;

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UILabel *collectionNumLab;
@property (weak, nonatomic) IBOutlet UIButton *collectionBtn;

@end

@implementation TourismDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.recommend.title;
    
    self.mainViewModel = [[MainViewModel alloc] init];
    
    [self loadDataWithDataType:TourismDetailTypeWithIntroduction];
    
}

- (UIView *)tableViewHeaderView{
    
    if (!_tableViewHeaderView) {
        float height = kScreenSize.width * 0.5;
        _tableViewHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, height)];
        
        SDCycleScrollView *scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenSize.width, height) delegate:nil placeholderImage:nil];
        
        NSMutableArray *imageArray = [[NSMutableArray alloc] initWithCapacity:[self.mainViewModel.traveltrip.banner count]];
        [self.mainViewModel.traveltrip.banner enumerateObjectsUsingBlock:^(Banner *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [imageArray addObject:obj.imgUrl];
        }];
        
        scrollView.imageURLStringsGroup = imageArray;
        
        [_tableViewHeaderView addSubview:scrollView];
        [scrollView setBackgroundColor:[UIColor orangeColor]];
    }
    
    return _tableViewHeaderView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CustomMoveItemView *customMoveItemView = [[CustomMoveItemView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 40) withItems:@[@"线路详情",@"线路评价",@"服务介绍"]];
    [customMoveItemView setCustoMoveItemBlock:^(TourismDetailType type, UILabel *lab) {
        switch (type) {
            case TourismDetailTypeWithIntroduction: {
                if (isRequestTourismDetail) {
                    self.myTableView.tableFooterView = self.tourismDetailView;
                }else{
                    [self loadTourisDetailsData];
                }
                break;
            }
            case TourismDetailTypeWithEvaluate: {
                if (isRequestTourisEvaluate) {
                    self.myTableView.tableFooterView = self.tourisEvaluateView;
                }else{
                    [self loadTourisEvaluate];
                }
                break;
            }
            case TourismDetailTypeWithService: {
                if (isRequestServiceIntroduction) {
                    self.myTableView.tableFooterView = self.serviceIntroductionView;
                }else{
                    [self loadServiceIntroduction];
                }
                break;
            }
        }
    }];
    return customMoveItemView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (void)loadDataWithDataType:(TourismDetailType)type{
    
    switch (type) {
        case TourismDetailTypeWithIntroduction: {
            [self loadTourisDetailsData];
            break;
        }
        case TourismDetailTypeWithEvaluate: {
            [self loadTourisEvaluate];
            break;
        }
        case TourismDetailTypeWithService: {
            [self loadServiceIntroduction];
            break;
        }
    }
    
}

// 加载路程介绍
- (void)loadTourisDetailsData{
    self.mainViewModel.typeId = self.recommend.Id;
    
    [[self.mainViewModel getTourisDetails] subscribeError:^(NSError *error) {
        
    } completed:^{
        
    }];
    
    [RACObserve(self.mainViewModel, traveltrip) subscribeNext:^(id x) {
        
        if (x) {
            
            isRequestTourismDetail = YES;
            
            self.myTableView.tableHeaderView = self.tableViewHeaderView;
            
            [self showCollectionState:self.mainViewModel.traveltrip.isCollection withCollectionNum:self.mainViewModel.traveltrip.collectionNum];
            
            // 线路详情
            self.myTableView.tableFooterView = [self tourismDetailView];
        }
    }];
}

// 加载线路评价
- (void)loadTourisEvaluate{
    
    self.mainViewModel.tourisId = self.recommend.Id;
    
    [[self.mainViewModel getTourisEvaluate] subscribeError:^(NSError *error) {
        
    } completed:^{
        
    }];
    
    [RACObserve(self.mainViewModel, tourisEvaluate) subscribeNext:^(id x) {
        if (x) {
            
            isRequestTourisEvaluate = YES;
            
            self.tourisEvaluateView.tourisEvaluate = self.mainViewModel.tourisEvaluate;
            
            // 线路评价
            self.myTableView.tableFooterView = [self tourisEvaluateView];
        }
    }];
}

// 加载服务介绍
- (void)loadServiceIntroduction{
    
    self.mainViewModel.tourisId = self.recommend.Id;
    
    [[self.mainViewModel getServiceIntroduction] subscribeNext:^(NSString *value) {
        
        isRequestServiceIntroduction = YES;
        self.myTableView.tableFooterView = self.serviceIntroductionView;
        
        ServiceIntroduction *serviceIntroduction = [ServiceIntroduction mj_objectWithKeyValues:value];
        self.serviceIntroductionView.content = serviceIntroduction.serviceInfo;
        
    } error:^(NSError *error) {
        
    } completed:^{
        
    }];
}

- (IBAction)addRoteAction:(id)sender {
    
    [[self.mainViewModel addDriverOrRoteId] subscribeNext:^(id value) {
        
        RoteCollection *roteCollection = [RoteCollection mj_objectWithKeyValues:value];
        
        [self showCollectionState:roteCollection.state withCollectionNum:roteCollection.collNum];
    } error:^(NSError *error) {
        
    } completed:^{
        
    }];
}

// 拼车
- (IBAction)carPoolAction:(id)sender {
}

// 包车
- (IBAction)charteredAction:(id)sender {
    CarListViewController *controller = [[CarListViewController alloc] init];
    controller.recommend = self.recommend;
    [self.navigationController pushViewController:controller animated:YES];
}

// 显示收藏状态
- (void)showCollectionState:(BOOL)isCollection withCollectionNum:(NSInteger)num{
    
    self.collectionNumLab.text = [@(num) stringValue];
    
    if (isCollection) {
        [self.collectionBtn setImage:[UIImage imageNamed:@"collection_off"] forState:UIControlStateNormal];
    }else{
        [self.collectionBtn setImage:[UIImage imageNamed:@"collection_on"] forState:UIControlStateNormal];
    }
}

- (TourisEvaluateView *)tourisEvaluateView{
 
    if (!_tourisEvaluateView) {
        _tourisEvaluateView = [[TourisEvaluateView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height - kScreenSize.width * 0.5 - 40)];
    }
    
    return _tourisEvaluateView;
}

- (TourismDetailView *)tourismDetailView{
    if (!_tourismDetailView) {
        _tourismDetailView = [[TourismDetailView alloc] init];
        _tourismDetailView.viewlist = self.mainViewModel.traveltrip.traveltriplist;
    }
    
    return _tourismDetailView;
}

- (ServiceIntroductionView *)serviceIntroductionView{
    if (!_serviceIntroductionView) {
        _serviceIntroductionView = [[ServiceIntroductionView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height - kScreenSize.width * 0.5 - 40)];
        _serviceIntroductionView.tag = 1000;
    }
    return _serviceIntroductionView;
}

@end
