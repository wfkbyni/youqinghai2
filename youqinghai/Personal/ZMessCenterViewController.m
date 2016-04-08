//
//  ZMessCenterViewController.m
//  youqinghai
//
//  Created by snailz on 16/3/28.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "ZMessCenterViewController.h"
#import "UIViewController+TableView.h"
#import "ZmessCenterCell.h"
#import "PersonalViewModel.h"
#import "ZUserMessModel.h"
#import "ZMessDetailViewController.h"
@interface ZMessCenterViewController ()
@property(nonatomic,strong)NSMutableArray *messAr;
@end

@implementation ZMessCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息中心";
    
    self.view.backgroundColor = spaceColor238238238();
    self.tableView.backgroundColor = [UIColor clearColor];
   // self.tableView.separatorStyle = NO;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZmessCenterCell" bundle:nil] forCellReuseIdentifier:@"ZmessCenterCell"];
    [self getNet];
    // Do any additional setup after loading the view.
}
-(void)getNet
{
    RACSignal *signal = [[[PersonalViewModel alloc]init]getMessData];
    __weak ZMessCenterViewController *blockSelf= self;
    [signal subscribeNext:^(id x) {
        NSArray *ar =  [NSJSONSerialization JSONObjectWithData:[((NSString *)x) dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        self.messAr = [ZUserMessModel mj_objectArrayWithKeyValuesArray:ar];
        NSLog(@"%@",self.messAr );
        [blockSelf.tableView reloadData];
    }];
}
#pragma mark - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

{
    
    return self.messAr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZmessCenterCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"ZmessCenterCell"];
    cell.messMod = self.messAr[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
 
    return  10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return  120;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    // 下面这几行代码是用来设置cell的上下行线的位置
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 20, 0, 20)];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ZMessDetailViewController *mdv = [[ZMessDetailViewController alloc]init];
    mdv.messMod =self.messAr[indexPath.row];
    [self.navigationController pushViewController:mdv animated:YES];
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
