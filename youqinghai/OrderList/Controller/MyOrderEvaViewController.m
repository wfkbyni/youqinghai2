//
//  MyOrderEvaViewController.m
//  youqinghai
//
//  Created by snailz on 16/4/14.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "MyOrderEvaViewController.h"
#import "UIViewController+TableView.h"
#import "ZTextViewCell.h"
#import "MyOrderEvaCell.h"
#import "EvaDriverViewController.h"
@interface MyOrderEvaViewController ()
@property(strong,nonatomic)NSString *str ;
@property(assign,nonatomic)NSInteger level ;
@end

@implementation MyOrderEvaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评价景点";
    self.images = [NSMutableArray array];
    self.height  = imageViewH+ImageH+12 ;
     self.view.backgroundColor = spaceColor238238238();
    self.tableView.backgroundColor = [UIColor clearColor];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 44)];
    title.text = @"  亲,对景点路线进行评价吧.";
    title.textColor = [UIColor darkGrayColor];
    title.font = [UIFont systemFontOfSize:15];
    self.tableView.tableHeaderView = title;
    self.tableView.tableFooterView =  [self footView];
    [self UIBarButton];
    // Do any additional setup after loading the view.
}
-(UIView*)footView
{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"下一步" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor redColor]];
    button.layer.cornerRadius = 4;
    [button addTarget:self action:@selector(regis) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(12, 20, self.view.frame.size.width-24, 40);
    [view addSubview:button];
    return view;
}
-(void)UIBarButton
{
    UIButton *btn             = [[UIButton alloc] init];
    [btn setTitle:@"跳过" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font  = [UIFont systemFontOfSize:14];
    btn.contentMode = UIViewContentModeLeft;
    CGFloat width = [@"跳过" boundingRectWithSize:CGSizeMake(200, 40) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.width;
    btn.size                  = CGSizeMake(width, 40);
    btn.titleLabel.textAlignment = NSTextAlignmentRight;
    [btn addTarget:self action:@selector(vcPush) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}
-(void)vcPush
{
    EvaDriverViewController *edv = [[EvaDriverViewController alloc]init];
//    edv.orderStr =self.str;
//    edv.orderlevel = self.level;
//    edv.orderImage = self.images;
    edv.eva = NO;
    edv.listMod =self.listMod;

    [self.navigationController pushViewController:edv animated:YES];
}
-(void)regis
{
    if (!self.str.length||!self.level) {
        UIAlertView *av= [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入内容和评分" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [av show];
        return;
    }
    EvaDriverViewController *edv = [[EvaDriverViewController alloc]init];
    edv.orderStr =self.str;
    edv.orderlevel = self.level;
    edv.eva = YES;
    edv.listMod =self.listMod;
    edv.orderImage = self.images;
    [self.navigationController pushViewController:edv animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row==0) {
        MyOrderEvaCell *cell = [[NSBundle mainBundle] loadNibNamed:@"MyOrderEvaCell" owner:nil options:nil].firstObject;
        cell.starView.starCount = self.level;
        cell.evaNum.text = [@(self.level).stringValue stringByAppendingString:@".0分"];
        cell.evaNumBlock = ^(NSInteger level){
            self.level = level;
        };
        return cell;
    }
    ZTextViewCell   *cell =  [[NSBundle mainBundle] loadNibNamed:@"ZTextViewCell" owner:nil options:nil].firstObject;
    cell.controller =self;
    cell.images = self.images;
    cell.placeholder.text = @"请输入您的评价内容";
   
      cell.photo = @"";
        cell.textViewheight.constant = 145;
    cell.textView.text = self.str;
    if (cell.textView.text.length == 0) {
        cell.placeholder.hidden = NO;
    }else{
        cell.placeholder.hidden = YES;
    }
    cell.TextBlcok = ^(NSString *text)
    {
        self.str = text;
    };
    cell.imageBlcok = ^(NSMutableArray *imageAr)
    {
        self.images = imageAr;
        [self.tableView reloadData];
    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    // 下面这几行代码是用来设置cell的上下行线的位置
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 12, 0, 12)];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 55;
    }
    if (self.images.count>=4) {
        return imageViewH+ImageH+5+ImageH+12;
    }
    return self.height;
    
    
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
