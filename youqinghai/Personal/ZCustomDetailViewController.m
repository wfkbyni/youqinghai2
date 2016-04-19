//
//  ZCustomDetailViewController.m
//  youqinghai
//
//  Created by snailz on 16/4/19.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "ZCustomDetailViewController.h"
#import "UIViewController+TableView.h"
#import "ZModifyTextCell.h"
#import "RequestBaseAPI+Personal.h"
#import "ZCostomDetModel.h"
@interface ZCustomDetailViewController ()
@property(nonatomic,strong)ZCostomDetModel *cosDetMod;
@end

@implementation ZCustomDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"定制旅游详情";
    self.view.backgroundColor = spaceColor238238238();
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.hidden=YES;
    [self getNet];
    // Do any additional setup after loading the view.
}
-(void)getNet
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    RACSignal *signal = [[RequestBaseAPI standardAPI] userCustomDetailWithcustomId:self.cusMod.ID];
   
    [signal subscribeNext:^(id x) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[((NSString *)x) dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        _cosDetMod = [ZCostomDetModel mj_objectWithKeyValues:dic];
        self.tableView.hidden=NO;
        [self.tableView reloadData];
    }];
    [signal subscribeError:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

{
    if (section==0) {
        return 4;
    }
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZModifyTextCell  *cell =  [[NSBundle mainBundle] loadNibNamed:@"ZModifyTextCell" owner:nil options:nil].firstObject;
    cell.selectionStyle = 0;
    cell.lableText.textColor = [UIColor colorWithRed:0.286 green:0.286 blue:0.298 alpha:1.000];
    cell.fieldText.textColor = [UIColor colorWithWhite:0.667 alpha:1.000];
    cell.fieldText.userInteractionEnabled=NO;
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    cell.lableText.text = @"联系人";
                    cell.fieldText.text = _cosDetMod.contacts;
                    
                   
                }
                    break;
                case 1:
                {
                    cell.lableText.text = @"联系电话";
                    cell.fieldText.text =_cosDetMod.phone;
                    cell.fieldText.keyboardType = UIKeyboardTypePhonePad;
                
                }
                    break;
                case 2:
                    cell.lableText.text = @"出游时间";
                    cell.fieldText.text = _cosDetMod.travelTime;
                    cell.fieldText.userInteractionEnabled = NO;
                    
                    
                    break;
                case 3:
                {
                    cell.lableText.text = @"出游人数";
                    cell.fieldText.text = _cosDetMod.travelnum;
                    cell.fieldText.keyboardType = UIKeyboardTypePhonePad;
                
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
                    cell.lableText.text = @"旅游出发地";
                    cell.fieldText.text = _cosDetMod.departure;
                   
                }
                    break;
                case 1:
                {
                    cell.lableText.text = @"途径的景点";
                    cell.fieldText.text = _cosDetMod.channelscenicspot;
                   
                }
                    break;
                case 2:
                {
                    cell.lableText.text = @"旅游目的地";
                    cell.fieldText.text =_cosDetMod.destination;
                }
                    break;
                case 3:
                {
                    cell.lableText.text = @"申请时间";
                    cell.fieldText.text = _cosDetMod.applyTime;
                }
                    break;
                case 4:
                {
                    cell.lableText.text = @"状态";
                    cell.fieldText.text =_cosDetMod.state.integerValue?@"已处理":@"待处理";
                    cell.fieldText.textColor = [UIColor colorWithRed:0.976 green:0.384 blue:0.408 alpha:1.000];
                }
                    break;
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 12;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
     
    return  44;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    // 下面这几行代码是用来设置cell的上下行线的位置
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 20, 0, 20)];
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
