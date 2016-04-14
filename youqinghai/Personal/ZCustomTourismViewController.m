//
//  ZCustomTourismViewController.m
//  youqinghai
//
//  Created by snailz on 16/4/6.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "ZCustomTourismViewController.h"
#import "UIViewController+TableView.h"
#import "ZCusTourCell.h"
#import "ZCustomTourAddViewController.h"
#import "RequestBaseAPI+Personal.h"
#import "ZCustomListModel.h"
@interface ZCustomTourismViewController ()
@property(nonatomic,strong)NSMutableArray *cusAr;
@property(copy,nonatomic)NSString *pages;
@end

@implementation ZCustomTourismViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"定制旅游";
    self.view.backgroundColor = spaceColor238238238();
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZCusTourCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ZCusTourCell"];
    [self UIBarButton];
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    self.tableView.mj_header = header;
    
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.pages = @(self.pages.integerValue+1).stringValue;
        [self getNet];
    }];
    
    self.tableView.mj_footer.hidden = YES;
    [self.tableView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
}
-(void)headerRefresh
{
    self.pages = @"1";
    [self getNet];
}
-(void)getNet
{
    RACSignal *signal = [[RequestBaseAPI standardAPI] userCustomListWithPageIndex:self.pages withPageSize:@"30"];
    __weak ZCustomTourismViewController *blockSelf= self;
    [signal subscribeNext:^(id x) {
        endRefesh
        self.tableView.mj_footer.hidden = NO;

        NSArray *ar =  [NSJSONSerialization JSONObjectWithData:[((NSString *)x) dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        if (self.pages.integerValue!=1) {
            if ([ar count]) {
                [self.cusAr addObjectsFromArray:[ZCustomListModel mj_objectArrayWithKeyValuesArray:ar]];
                
                [self.tableView reloadData];
            }else{
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            
            return ;
        }
        self.cusAr = [ZCustomListModel mj_objectArrayWithKeyValuesArray:ar];
        NSLog(@"%@",self.cusAr );
        if (self.cusAr.count<30) {
            
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            
        }
        [blockSelf.tableView reloadData];
 
    }];
    [signal subscribeError:^(NSError *error) {
        endRefesh
        self.tableView.mj_footer.hidden = NO;
         [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }];
}
-(void)UIBarButton
{
    UIButton *btn             = [[UIButton alloc] init];
    [btn setTitle:@"新增" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font  = [UIFont systemFontOfSize:14];
    btn.contentMode = UIViewContentModeLeft;
    CGFloat width = [@"新增" boundingRectWithSize:CGSizeMake(200, 40) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.width;
    btn.size                  = CGSizeMake(width, 40);
    btn.titleLabel.textAlignment = NSTextAlignmentRight;
    [btn addTarget:self action:@selector(addPush) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}
-(void)addPush
{
    ZCustomTourAddViewController *cta = [[ZCustomTourAddViewController alloc]init];
    [self.navigationController pushViewController:cta animated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

{
    
    return self.cusAr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 12;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    // 下面这几行代码是用来设置cell的上下行线的位置
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 12, 0, 12)];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCusTourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZCusTourCell"];
    cell.listModel = self.cusAr[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
    return  80;
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
