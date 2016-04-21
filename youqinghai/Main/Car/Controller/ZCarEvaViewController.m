//
//  ZCarEvaViewController.m
//  youqinghai
//
//  Created by snailz on 16/4/21.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "ZCarEvaViewController.h"
#import "UIViewController+TableView.h"
#import "DriverCarCommentCell.h"
#import "ZPageView.h"
#import "RequestBaseAPI+Car.h"
@implementation carEva
@end;
@interface ZCarEvaViewController ()<ZPageViewDelegate>
@property (nonatomic, strong) NSMutableArray *evalist;
@property(weak,nonatomic)ZPageView *pageView;//选择器
@property(assign,nonatomic)NSInteger pages;
@property(assign,nonatomic)NSInteger evaType;
@property(strong,nonatomic)carEva *carevaMod;
@end

@implementation ZCarEvaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"全部评价";
    [self setPageView];
    self.view.backgroundColor = spaceColor238238238();
    self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.frame = CGRectMake(0, 108, self.view.frame.size.width, self.view.frame.size.height-108);
            [self.tableView registerNib:[UINib nibWithNibName:@"DriverCarCommentCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    self.tableView.mj_header = header;
    
 
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            self.pages =  self.pages+1;
            [self getNetData];
        }];
 
    
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer.hidden=YES;
    // Do any additional setup after loading the view.
}
-(void)headerRefresh
{
    self.pages = 1;
    [self getNetData];
}
-(void)getNetData
{
    RACSignal *signal = [[RequestBaseAPI standardAPI]getAllEvaDateWithdriverId:self.driverId withgrade:self.evaType?@(self.evaType).stringValue:@"" withpageIndex:@(self.pages).stringValue withpageSize:@"30"];
    __weak ZCarEvaViewController *blockSelf= self;
    [signal subscribeNext:^(id x) {
          self.tableView.mj_footer.hidden=NO;
        [blockSelf.tableView.mj_header endRefreshing];
        [blockSelf.tableView.mj_footer endRefreshing];
        NSDictionary *ar =  [NSJSONSerialization JSONObjectWithData:[((NSString *)x) dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        if (blockSelf.pages!=1) {
            if (ar.count) {
                [blockSelf.evalist addObjectsFromArray:[Eav mj_objectArrayWithKeyValuesArray:ar]];
                [blockSelf reloadData];
            }else{
                [blockSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            
            return ;
        }
        
        
        
        self.carevaMod= [carEva mj_objectWithKeyValues:ar];
        self.carevaMod.evalist = ar[@"eavList"];
        
        blockSelf.evalist = [NSMutableArray array];
        for (NSDictionary *dic in self.carevaMod.evalist) {
            [blockSelf.evalist addObject:[Eav mj_objectWithKeyValues:dic]];
        }
        NSLog(@"%@",blockSelf.evalist );
        if (blockSelf.evalist.count<30) {
             [blockSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        NSString *all = [NSString stringWithFormat:@"全部(%@)",self.carevaMod.countEva];
        NSString *praise = [NSString stringWithFormat:@"好评(%@)",self.carevaMod.praise];
        NSString *commentsEva = [NSString stringWithFormat:@"中评(%@)",self.carevaMod.commentsEva];
        NSString *bad = [NSString stringWithFormat:@"差评(%@)",self.carevaMod.bad];
        [self.pageView setButtonTitle:@[all,praise,commentsEva,bad]];
        [blockSelf reloadData];
        
    }];
    [signal subscribeError:^(NSError *error) {
          self.tableView.mj_footer.hidden=NO;
        [blockSelf.tableView.mj_header endRefreshing];
        [blockSelf.tableView.mj_footer endRefreshing];
    }];
}
-(void)setPageView
{
    CGRect frame = self.view.bounds;
    frame.size.height = 44;
    ZPageView *page = [[ZPageView alloc] initWithFrame:frame];
    page.delegate =self;
    page.frame = CGRectMake(0,64, frame.size.width, 44);
    NSArray *titles = @[@"全部",@"好评",@"中评",@"差评"];
    page.dataS = titles;
    _pageView = page;
    __weak typeof(ZCarEvaViewController) *weakSelf = self;
    [_pageView setSelectIndexAction:^(NSInteger index) {
        [weakSelf reloadData];
    }];
    [self.view addSubview:self.pageView];
}
-(void)pageView:(ZPageView *)pageView button:(UIButton *)btn
{
    
 
    self.evaType = btn.tag;
    self.pages  = 1;
    [self getNetData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

{
    
    return self.evalist.count;
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
    DriverCarCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.eav = _evalist[indexPath.row];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
+(float)calcCellHeight:(Eav *)eav{
    
    float height = 8 * 3 + 46;
    
    height += [eav.content calHeightWithWidth:kScreenSize.width - 70 withFontSize:14];
    
    return height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [[self class] calcCellHeight:_evalist[indexPath.row]];
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
