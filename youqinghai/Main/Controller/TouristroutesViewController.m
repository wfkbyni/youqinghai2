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

@interface TouristroutesViewController ()

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
    
    [self loadData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)loadData{
    self.mainViewModel = [[MainViewModel alloc] init];
    self.mainViewModel.typeId = self.tourismType.Id;
    
    [[self.mainViewModel getTouristroutesList] subscribeError:^(NSError *error) {
        
        NSLog(@"%@",error);
    } completed:^{
        
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
