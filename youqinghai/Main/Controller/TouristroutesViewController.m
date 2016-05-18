//
//  TouristroutesViewController.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/25.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "TouristroutesViewController.h"
#import "TourismDetailController.h"

#import "MainViewModel.h"

#import "RecommendTypeCell.h"

@interface TouristroutesViewController (){
    MJRefreshComponent *refreshComponent;
}

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic, strong) MainViewModel *mainViewModel;

@end

#define recommendTypeCell @"RecommendTypeCell"

@implementation TouristroutesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.tourismType.typeName;
    
    [self.myTableView registerNib:[UINib nibWithNibName:recommendTypeCell bundle:nil] forCellReuseIdentifier:recommendTypeCell];
    
    self.myTableView.tableFooterView = [[UIView alloc] init];
    
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.mainViewModel.pageIndex = 1;
        [self.mainViewModel.recommends removeLastObject];
        refreshComponent = self.myTableView.mj_header;
        [self loadData];
    }];
    
    [self.myTableView.mj_header beginRefreshing];
    
    self.myTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.mainViewModel.pageIndex ++;
        refreshComponent = self.myTableView.mj_footer;
        [self loadData];
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)loadData{
    self.mainViewModel = [[MainViewModel alloc] init];
    self.mainViewModel.typeId = self.tourismType.Id;
    
    [[self.mainViewModel getTouristroutesList] subscribeError:^(NSError *error) {
        
    } completed:^{
        
        if (refreshComponent == self.myTableView.mj_header) {
            [self.myTableView.mj_header endRefreshing];
            if (self.mainViewModel.recommends.count % 10 == 0) {
                
            }else{
                [self.myTableView.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            if (self.mainViewModel.recommends.count % 10 == 0) {
                [self.myTableView.mj_footer endRefreshing];
            }else{
                [self.myTableView.mj_footer endRefreshingWithNoMoreData];
            }
        }
        
    }];
     
     [RACObserve(self.mainViewModel, recommends) subscribeNext:^(id x) {
         [self.myTableView reloadData];
     }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mainViewModel.recommends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RecommendTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendTypeCell forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.recommend = self.mainViewModel.recommends[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TourismDetailController *controller = [[TourismDetailController alloc] init];
    controller.recommend = self.mainViewModel.recommends[indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
}


@end
