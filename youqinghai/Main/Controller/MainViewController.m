//
//  MainViewController.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/22.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "MainViewController.h"
#import "RedirectViewController.h"
#import "TourismDetailController.h"

#import "MainViewModel.h"

#import "TourismTypeCell.h"
#import "RecommendTypeCell.h"


@interface MainViewController()<UITableViewDataSource,UITableViewDelegate>{
    SDCycleScrollView *bannerScrollView;
}

@property (nonatomic, strong) MainViewModel *mainViewModel;

@property (nonatomic, strong) UITableView *myTableView;

@property (nonatomic, strong) MJRefreshComponent *refreshComponent;

@end

#define tourismTypeCell @"TourismTypeCell"
#define recommendTypeCell @"RecommendTypeCell"

@implementation MainViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBarHidden = YES;
    
    self.mainViewModel = [[MainViewModel alloc] init];
    
    [self commonView];
    
    NSLog(@"%@",[ZUserModel shareUserModel].userId);
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)commonView{
    
    self.myTableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height - 44) style:UITableViewStyleGrouped];
    _myTableView.tableFooterView = [UIView new];
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    
    [_myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self.view addSubview:_myTableView];
    
    bannerScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.width * 0.8) delegate:nil placeholderImage:nil];
    [_myTableView setTableHeaderView:bannerScrollView];
    
    _myTableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        _refreshComponent = _myTableView.mj_header;
        
        self.mainViewModel.pageIndex = 1;
        [self requestBindData];
    }];
    [_myTableView.mj_header beginRefreshing];
    
    _myTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _refreshComponent = _myTableView.mj_footer;
        
        self.mainViewModel.pageIndex ++;
        [self requestBindData];
    }];
    
    
    [_myTableView registerNib:[UINib nibWithNibName:tourismTypeCell bundle:nil] forCellReuseIdentifier:tourismTypeCell];
    [_myTableView registerNib:[UINib nibWithNibName:recommendTypeCell bundle:nil] forCellReuseIdentifier:recommendTypeCell];
}

- (void)requestBindData{
    
    [[self.mainViewModel getHomePageData] subscribeNext:^(HomePageData *homePageData) {
        
        if (_refreshComponent == _myTableView.mj_header) {
            [_myTableView.mj_header endRefreshing];
        }else{
            if (homePageData.recommend.count % 10 != 0) {
                [self.myTableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [_myTableView.mj_footer endRefreshing];
            }
        }
        
        [self setBannerData];
        [self.myTableView reloadData];
        
    } error:^(NSError *error) {
        [_myTableView.mj_header endRefreshing];
        [_myTableView.mj_footer endRefreshing];
    }];
    
}

- (void)setBannerData{
    NSMutableArray *imageArray = [[NSMutableArray alloc] initWithCapacity:[self.mainViewModel.homePageData.banner count]];
    //NSMutableArray *titleArray = [[NSMutableArray alloc] initWithCapacity:[self.mainViewModel.homePageData.banner count]];
    [self.mainViewModel.homePageData.banner enumerateObjectsUsingBlock:^(Banner *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [imageArray addObject:obj.imgUrl];
        //[titleArray addObject:obj.title];
    }];
    
    if (imageArray.count > 0) {
        bannerScrollView.imageURLStringsGroup = imageArray;
    }
    //scrollView.titlesGroup = titleArray;
    
    @weakify(self)
    [bannerScrollView setClickItemOperationBlock:^(NSInteger index) {
        @strongify(self)
        Banner *banner = self.mainViewModel.homePageData.banner[index];
        
        RedirectViewController *controller = [[RedirectViewController alloc] init];
        controller.banner = banner;
        
        [self.navigationController pushViewController:controller animated:YES];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSString *title;
    if (section == 0) {
        title = @"线路分类";
    }else{
        title = @"特别推荐";
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 40)];
    [view setBackgroundColor:[UIColor whiteColor]];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 5, 20)];
    [lineView setBackgroundColor:[UIColor colorWithRed:0.15 green:0.67 blue:0.95 alpha:1.00]];
    [lineView viewWithCornerRadius:3];
    
    [view addSubview:lineView];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, kScreenSize.width - 25, 40)];
    [titleLab setText:title];
    [titleLab setFont:[UIFont systemFontOfSize:17.0f]];
    
    [view addSubview:titleLab];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }else{
        return 0.1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 10)];
        [view setBackgroundColor:[UIColor colorWithRed:0.87 green:0.87 blue:0.88 alpha:1.00]];
        return view;
    }else{
        return nil;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return self.mainViewModel.homePageData.recommend.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 120;
    }else{
        return 160;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        TourismTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:tourismTypeCell forIndexPath:indexPath];
        cell.tourismTypes = self.mainViewModel.homePageData.tourismType;
        cell.navigationController = self.navigationController;
        return cell;
    }else{
        RecommendTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendTypeCell forIndexPath:indexPath];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.recommend = self.mainViewModel.homePageData.recommend[indexPath.row];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.navigationController.navigationBarHidden = NO;
    
    Recommend *recommend = self.mainViewModel.homePageData.recommend[indexPath.row];
    
    [[NSUserDefaults standardUserDefaults] setObject:@(recommend.Id) forKey:YQHTourisId];
    
    TourismDetailController *controller = [[TourismDetailController alloc] init];
    controller.recommend = recommend;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
