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
#import "ConfirmOrderController.h"
#import "UMSocialData.h"
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
    
    self.myTableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    
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
        
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setFrame:CGRectMake(10, 30, 40, 40)];
        [backBtn setImage:[UIImage imageNamed:@"arrow_left"] forState:UIControlStateNormal];
        
        [_tableViewHeaderView addSubview:backBtn];
        
        UIButton *sharedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sharedBtn.frame = CGRectMake(CGRectGetWidth(_tableViewHeaderView.frame) - 40 - 10, 30, 40, 40);
        [sharedBtn setImage:[UIImage imageNamed:@"shard"] forState:UIControlStateNormal];
        
        [_tableViewHeaderView addSubview:sharedBtn];
        
        [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        [sharedBtn addTarget:self action:@selector(sharedAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _tableViewHeaderView;
}

- (void)backAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)sharedAction:(UIButton *)sender{
    //[self.view makeToast:@"分享功能待定..."];
//    [UMSocialSnsService presentSnsIconSheetView:self
//                                         appKey:@"570b744e67e58e12e2000466"
//                                      shareText:@"快来使用游青海,定制您的专属旅程 http://www.baidu.com"
//                                     shareImage:[UIImage imageNamed:@"AppIcon"]
//                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone,UMShareToSina]
//                                       delegate:nil];
    sender.userInteractionEnabled=NO;
    [[SDWebImageDownloader sharedDownloader]downloadImageWithURL:[NSURL URLWithString:self.recommend.imgUrl] options:SDWebImageDownloaderUseNSURLCache progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        [UMSocialData defaultData].extConfig.qqData.title = self.recommend.title;
        [UMSocialData defaultData].extConfig.wechatSessionData.title=self.recommend.title;
        [UMSocialData defaultData].extConfig.wechatTimelineData.title=self.recommend.title;
        [UMSocialData defaultData].extConfig.sinaData.shareText =[NSString stringWithFormat:@"%@ http://www.baidu.com",self.recommend.title];
        [UMSocialSnsService presentSnsIconSheetView:self appKey:@"570b744e67e58e12e2000466"shareText:self.recommend.introduce shareImage:image shareToSnsNames:@[UMShareToWechatFavorite,UMShareToWechatTimeline,UMShareToWechatSession,UMShareToQQ,UMShareToQzone] delegate:nil];
        sender.userInteractionEnabled=YES;

    }];
   

   // [CoreUmengShare show:self text:dic.object[@"content"] image:dic.object[@"image"]];

    
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
            
            [self showCollectionState:self.mainViewModel.traveltrip.isCollection
                    withCollectionNum:self.mainViewModel.traveltrip.collectionNum];
            
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
    
    [[self.mainViewModel addDriverOrRoteIdWithUserId:[[ZUserModel shareUserModel].userId integerValue] withTravelId:self.mainViewModel.tourisId withType:0] subscribeNext:^(ResponseBaseData *data) {
        
        
        
    } error:^(NSError *error) {
        [self.view makeToast:error.localizedDescription];
    } completed:^{
        
    }];
}

// 拼车
- (IBAction)carPoolAction:(id)sender {
    ConfirmOrderController *controller = [[ConfirmOrderController alloc] init];
    controller.isCarpool = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

// 包车
- (IBAction)charteredAction:(id)sender {
    self.title = @"";
    CarListViewController *controller = [[CarListViewController alloc] init];
    controller.recommend = self.recommend;
    [self.navigationController pushViewController:controller animated:YES];
}

// 显示收藏状态
- (void)showCollectionState:(BOOL)isCollection withCollectionNum:(NSInteger)num{
    
    self.collectionNumLab.text = [NSString stringWithFormat:@"收藏(%@)",@(num)];
    
    if (isCollection) {
        [self.collectionBtn setImage:[UIImage imageNamed:@"favorites"] forState:UIControlStateNormal];
    }else{
        [self.collectionBtn setImage:[UIImage imageNamed:@"favorites"] forState:UIControlStateNormal];
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
        [[NSUserDefaults standardUserDefaults] setObject:@(self.mainViewModel.traveltrip.traveltriplist.count) forKey:YQHViewlist];
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
