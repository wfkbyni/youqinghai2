//
//  ZMyFollowViewController.m
//  youqinghai
//
//  Created by snailz on 16/4/7.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "ZMyFollowViewController.h"
 #import "ZPageView.h"
#import "ZRouteFTableView.h"
#import "ZDriverFTableView.h"
#import "ZTravelFTableView.h"
#import "ZFowUserTableView.h"
#import "TourismDetailController.h"
#import "CarDetailController.h"
#import "HybridJSBusinessApi.h"
@interface ZMyFollowViewController ()<ZPageViewDelegate,UIScrollViewDelegate>
 @property(weak,nonatomic)ZPageView *pageView;
@property(nonatomic,weak)UIScrollView *scrollView;
@property (nonatomic, weak) ZRouteFTableView *routeFTableView;
@property (nonatomic, weak) ZDriverFTableView *driverFTableView;
@property (nonatomic, weak) ZTravelFTableView *travelFTableView;
@property (nonatomic, weak) ZFowUserTableView *fowUserTableView;
@end

@implementation ZMyFollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的关注";
    self.view.backgroundColor = [UIColor colorWithRed:0.922 green:0.925 blue:0.929 alpha:1.000];
     [self setPageView];
 [self setScrollView];
    [self setRouteFTableView];
    [self setDriverFTableView];
    [self setTravelFTableView];
    [self setFowUserTableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sharAct:) name:@"sharAct" object:nil];
    
    // Do any additional setup after loading the view.
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
 
-(void)sharAct:(NSNotification*)not
{
    ZTravelModel *traMod = not.object[@"t"];
  
    
    
    [UMSocialData defaultData].extConfig.qqData.title =  traMod.content;
    [UMSocialData defaultData].extConfig.wechatSessionData.title=traMod.content;
    [UMSocialData defaultData].extConfig.wechatTimelineData.title=traMod.content;
    NSString *url = [NSString stringWithFormat:@"http://www.sinata.cn:9402/swimQinghai/share?code=0&Id=%zi", traMod.ID];
    [UMSocialWechatHandler setWXAppId:@"wxeb076ac34fb771b7" appSecret:@"6dc56b5630579fa7d4b614edabfa3434" url:url];
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"1799384586" secret:@"dc96ffc3a2ca7eeb3f8e8c63d8493d9f" RedirectURL:url];
    [UMSocialQQHandler setQQWithAppId:@"1105195687" appKey:@"1Mj6wJJiiYtLZJaJ" url:url];
    
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"570b744e67e58e12e2000466"shareText:traMod.content shareImage:not.object[@"i"] shareToSnsNames:@[UMShareToWechatTimeline,UMShareToWechatSession,UMShareToQQ,UMShareToQzone,UMShareToSina] delegate:nil];
}
-(void)setRouteFTableView
{
    ZRouteFTableView *tableView = [[ZRouteFTableView alloc] initWithFrame:CGRectMake(0, 12, self.scrollView.frame.size.width, self.scrollView.frame.size.height-12)style:UITableViewStyleGrouped];
    self.routeFTableView = tableView;
    tableView.backgroundColor= [UIColor whiteColor];
    [self.scrollView addSubview:tableView];
    
    
    tableView.selectBlock = ^(NSIndexPath *indexPath){
        Recommend *recommend = self.routeFTableView.tabAr[indexPath.row];
        
        [[NSUserDefaults standardUserDefaults] setObject:@(recommend.Id) forKey:YQHTourisId];
        
        TourismDetailController *controller = [[TourismDetailController alloc] init];
        controller.recommend = recommend;
        [self.navigationController pushViewController:controller animated:YES];
    };
    
}
-(void)setDriverFTableView
{
    ZDriverFTableView *tableView = [[ZDriverFTableView alloc] initWithFrame:CGRectMake(self.scrollView.frame.size.width*2, 12, self.scrollView.frame.size.width, self.scrollView.frame.size.height-12)style:UITableViewStylePlain];
    self.driverFTableView = tableView;
    tableView.backgroundColor= [UIColor whiteColor];
    [self.scrollView addSubview:tableView];
     tableView.selectBlock = ^(NSIndexPath *indexPath){
       ZDriverModel *driverMod= self.driverFTableView.tabAr[indexPath.row];
         CarDetailController *car = [[CarDetailController alloc]init];
         car.car = [[Car alloc]init];
         car.car.driverId = driverMod.driverId.integerValue;
         [self.navigationController pushViewController:car animated:YES];
     };
}
-(void)setTravelFTableView
{
    ZTravelFTableView *tableView = [[ZTravelFTableView alloc] initWithFrame:CGRectMake(self.scrollView.frame.size.width, 12, self.scrollView.frame.size.width, self.scrollView.frame.size.height-12)style:UITableViewStyleGrouped];
    self.travelFTableView = tableView;
    tableView.selectBlock = ^(NSIndexPath *indexPath){
        ZTravelModel *traMod= self.travelFTableView.tabAr[indexPath.row];
        [self jumpToTravelDetail:traMod.ID];
    };
    [self.scrollView addSubview:tableView];
}
-(void)setFowUserTableView
{
    ZFowUserTableView *tableView = [[ZFowUserTableView alloc] initWithFrame:CGRectMake(self.scrollView.frame.size.width*3, 12, self.scrollView.frame.size.width, self.scrollView.frame.size.height-12)style:UITableViewStylePlain];
    self.fowUserTableView = tableView;
    
    tableView.backgroundColor= [UIColor whiteColor];
    tableView.selectBlock = ^(NSIndexPath *indexPath){
        ZFowUserModel *userModel= self.fowUserTableView.tabAr[indexPath.row];
        [self jumpToPersonDetail:userModel.userId];
    };
    [self.scrollView addSubview:tableView];
}
-(void)setPageView
{
    ZPageView *page = [[ZPageView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 44)];
    page.dataS = @[@"关注路线",@"关注游记",@"关注司机",@"关注用户"];
    page.delegate=self;
    _pageView = page;
    [self.view addSubview:page];
}
- (void)setScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 108, self.view.frame.size.width, self.view.frame.size.height-108)];
    [self.view addSubview:scrollView];
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width*4, 0);
    scrollView.pagingEnabled=YES;
    scrollView.delegate=self;
    scrollView.showsVerticalScrollIndicator = FALSE;
    scrollView.showsHorizontalScrollIndicator = FALSE;
    _scrollView= scrollView;
}
-(void)pageView:(ZPageView *)pageView button:(UIButton *)btn
{
    [self.scrollView setContentOffset:CGPointMake(self.view.frame.size.width*btn.tag, 0) animated:YES];
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView ==self.scrollView) {
        int page = scrollView.contentOffset.x/self.view.frame.size.width;
        [_pageView selectedIndex:@(page)];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
