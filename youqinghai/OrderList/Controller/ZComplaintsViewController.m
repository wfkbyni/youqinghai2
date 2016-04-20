//
//  ZComplaintsViewController.m
//  youqinghai
//
//  Created by snailz on 16/4/20.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "ZComplaintsViewController.h"
#import "UIViewController+TableView.h"
#import "ZTextViewCell.h"
#import "RequestBaseAPI+Order.h"
#import "ZCWhyViewController.h"
@interface ZComplaintsViewController ()
@property(strong,nonatomic)NSString *str ;
@property(strong,nonatomic)NSString *whystr ;
@end

@implementation ZComplaintsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"投诉司机";
    self.view.backgroundColor = spaceColor238238238();
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = [self footView];
    // Do any additional setup after loading the view.
}
-(UIView*)footView
{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor redColor]];
    button.layer.cornerRadius = 4;
    [button addTarget:self action:@selector(regis) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(12, 20, self.view.frame.size.width-24, 40);
    [view addSubview:button];
    return view;
}
-(void)regis
{
    
        if (!self.str.length||!self.whystr.length) {
            UIAlertView *av= [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入内容和原因" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [av show];
            return;
        }
     [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    RACSignal *signal = [[RequestBaseAPI standardAPI]  sendComplaintWithorderId:self.listMod.orderId withreason:self.whystr withtitle:self.str];
    [signal subscribeNext:^(id x) {
        NSLog(@"%@",x);
         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        UIAlertView *av= [[UIAlertView alloc]initWithTitle:@"提示" message:@"感谢您的反馈,我们会尽快处理" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [av show];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [signal subscribeError:^(NSError *error) {
         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

{
    return 1;
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
    if (indexPath.section==0) {
        return 44;
    }
  
    return 240;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section==0) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.textLabel.text = @"投诉原因";
        cell.detailTextLabel.text = self.whystr.length?self.whystr:@"请选择投诉原因";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    ZTextViewCell   *cell =  [[NSBundle mainBundle] loadNibNamed:@"ZTextViewCell" owner:nil options:nil].firstObject;
    cell.controller =self;
    
    cell.placeholder.text = @"请输入您要投诉的内容";
    
    
    cell.textViewheight.constant = 240-24;
    cell.TextBlcok = ^(NSString *text)
    {
        self.str = text;
    };
 
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZCWhyViewController *cw  = [[ZCWhyViewController alloc]init];
    cw.selectBlock = ^(NSString* str){
        self.whystr = str;
        NSIndexSet *set = [NSIndexSet indexSetWithIndex:0];
        [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
        
    };
    [self.navigationController pushViewController:cw  animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 12;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
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
