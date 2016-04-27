//
//  InsuranceViewController.m
//  youqinghai
//
//  Created by 舒永超 on 16/4/19.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "InsuranceViewController.h"
#import "AddInsuranceController.h"
#import "InsuranceTableViewCell.h"

@interface InsuranceViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic, strong) NSArray *insuranceArray;
@end

@implementation InsuranceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"保险人";
    
    [self.view setBackgroundColor:[UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.00]];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"新增" style:UIBarButtonItemStyleDone target:self action:@selector(addInsuranceAction)];
 
    self.myTableView.tableFooterView = [UIView new];
    [self.myTableView setDataSource:self];
    [self.myTableView setDelegate:self];
    [self.myTableView registerNib:[UINib nibWithNibName:@"InsuranceTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self loadCacheData];
}

- (void)loadCacheData{
    
    [CardNo objectsFromCacheWithSQL:@" select * from CardNo " success:^(NSArray *array) {
        _insuranceArray = array;
        
        if (_InsuranceDataCall) {
            _InsuranceDataCall(array);
        }
        
        if (_insuranceArray.count >= _maxCount) {
            self.navigationItem.rightBarButtonItem.enabled = NO;
        }else{
            self.navigationItem.rightBarButtonItem.enabled = YES;
        }
        
        [self.myTableView reloadData];
    } failure:^(NSError *error) {
        [self.view makeToast:[error.userInfo objectForKey:@"message"]];
    }];
}

- (void)addInsuranceAction{
    AddInsuranceController *controller = [[AddInsuranceController alloc] init];
    [controller setAddSuccess:^{
        [self loadCacheData];
    }];
    [self.navigationController pushViewController:controller animated:YES];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"最多可添加%ld位被保人信息",_maxCount];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _insuranceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    InsuranceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    CardNo *cardNo = _insuranceArray[indexPath.row];
    cell.cardNoModel = cardNo;
    [[cell.deleteInsuranceBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [cardNo removefromCache];
        
        [self loadCacheData];
    }];
    return cell;
}

@end
