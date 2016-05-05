//
//  PersonalViewController.m
//  QingHaiTourClient
//
//  Created by mouxiaochun on 16/3/12.
//  Copyright © 2016年 mmc. All rights reserved.
//

#import "PersonalViewController.h"
#import "UIViewController+TableView.h"
#import "PersonalCell.h"
#import "ZPersanalHeaderView.h"
#import "ZUserModel.h"
#import "ZMessCenterViewController.h"
#import <FDFullscreenPopGesture/UINavigationController+FDFullscreenPopGesture.h>
#import "PersonalViewModel.h"
#import "ZRegisteredViewController.h"
#import "ZLoginViewController.h"
#import "ZPersonalDataViewController.h"
#import "ZMoreViewController.h"
#import "ZCustomTourismViewController.h"
#import "ZMyFollowViewController.h"
#import "OrdersViewController.h"
#import "ZOpinionViewController.h"
@interface TBCellItem : NSObject
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSString *title;

@end


@interface PersonalViewController ()<UMSocialUIDelegate>
{

    NSArray *_datasource;
}
@property(weak,nonatomic)ZPersanalHeaderView *headerView;
@end
@implementation PersonalViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    self.view.backgroundColor = spaceColor238238238();
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44);
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = [self setHeaderView];
    self.fd_prefersNavigationBarHidden =YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self getUserData];
}
-(void)getUserData
{
    if (![ZUserModel shareUserModel].userId) {
        __weak PersonalViewController *blockSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (![ZUserModel shareUserModel].userId) {
                [blockSelf getUserData];
                return ;
            }
            [_headerView setData];
        });
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_headerView setData];
}
-(UIView*)setHeaderView
{
    ZPersanalHeaderView *headerView = [[NSBundle mainBundle]loadNibNamed:@"ZPersonalHeaderView" owner:nil options:nil].firstObject;
    _headerView = headerView;
    headerView.viewController = self;
    __weak PersonalViewController *blockSelf= self;
    headerView.btnBlcok = ^(int type){
       
        if ([ZUserModel  pushLogin:self]) {
            return ;
        }
         
        if (type) {
            ZPersonalDataViewController *pdv = [[ZPersonalDataViewController alloc]init];
            [self.navigationController pushViewController:pdv animated:YES];
        }else{
            ZMoreViewController *per = [[ZMoreViewController alloc]init];
            [blockSelf.navigationController pushViewController:per animated:YES];
        }
        
  
    };
  // headerView.frame = CGRectMake(0, 0, self.view.frame.size.width, 200);
    return headerView;
}
-(void)loginPush
{
    ZLoginViewController *login = [[ZLoginViewController alloc]init];
    [self.navigationController pushViewController:login animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.datasource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

{
    NSArray *list = [self.datasource objectAtIndex:section];
    return list.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"PersonalCell";
    PersonalCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[PersonalCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.font = fontSystem14();
    }
    NSArray *list = [self.datasource objectAtIndex:indexPath.section];
    NSDictionary *info = list[indexPath.row];
    NSString *pic = [info objectForKey:@"pic"];
    UIImage *image = [UIImage imageNamed:pic];
    cell.imageView.image = image;
    NSString *title = [info objectForKey:@"title"];
    cell.textLabel.text = title;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return 10;
    }
    return  5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return  5;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (![ZUserModel shareUserModel].userId) {
        [self loginPush];
        return;
    }
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    OrdersViewController *ovc = [[OrdersViewController alloc]init];
                    [self.navigationController pushViewController:ovc animated:YES];
                }
                    break;
                case 1:
                {
                    ZMyFollowViewController *fvc = [[ZMyFollowViewController alloc]init];
                    [self.navigationController pushViewController:fvc animated:YES];
                    
                }
                    break;
                case 2:
                {
                    ZMessCenterViewController *mess =[[ZMessCenterViewController alloc]init];
                    [self.navigationController pushViewController:mess animated:YES];
                  
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    ZCustomTourismViewController *ctv = [[ZCustomTourismViewController alloc]init];
                     [self.navigationController pushViewController:ctv animated:YES];
                }
                    break;
                case 1:
                {
                    [UMSocialData defaultData].extConfig.qqData.title = @"游青海-带你体验青海的美";
                    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"游青海-带你体验青海的美";
                    [UMSocialData defaultData].extConfig.qzoneData.title = @"游青海-带你体验青海的美";
                    [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"游青海-带你体验青海的美";
                    [UMSocialData defaultData].extConfig.sinaData.shareText = @"游青海-带你体验青海的美";
                    
                    NSString *url = @"http://www.sinata.cn:9402/swimQinghai/share";
                    
                    [UMSocialWechatHandler setWXAppId:@"wxeb076ac34fb771b7" appSecret:@"6dc56b5630579fa7d4b614edabfa3434" url:url];
                    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"1799384586" secret:@"dc96ffc3a2ca7eeb3f8e8c63d8493d9f" RedirectURL:url];
                    [UMSocialQQHandler setQQWithAppId:@"1105195687" appKey:@"1Mj6wJJiiYtLZJaJ" url:url];
                    UIImage *image = [UIImage imageNamed:@"iconApp"];
                    [UMSocialSnsService presentSnsIconSheetView:self
                                                         appKey:@"570b744e67e58e12e2000466"
                                                      shareText:@"游青海APP将为您提供高质量的全省旅游用车等服务!"
                                                     shareImage:image
                                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone,UMShareToSina]
                                                       delegate:self];
                }
                    break;
                case  2:
                {
                    ZOpinionViewController *ovc = [[ZOpinionViewController alloc]init];
                     [self.navigationController pushViewController:ovc animated:YES];
                }
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
 
}
-(BOOL)isDirectShareInIconActionSheet{
    return YES;
}
- (NSArray *)datasource{
    
    if (!_datasource) {
        
        _datasource = @[@[@{@"pic":@"ordericon",@"title":@"我的订单"},@{@"pic":@"followIcon",@"title":@"我的关注"},@{@"pic":@"messIcon",@"title":@"消息中心"}],@[@{@"pic":@"customIcon",@"title":@"定制旅游"},@{@"pic":@"shareIcon",@"title":@"分享好友"},@{@"pic":@"ideaIcon",@"title":@"意见反馈"}] ];
        
    }
    return _datasource;
}

@end
