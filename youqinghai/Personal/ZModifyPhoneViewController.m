//
//  ZModifyPhoneViewController.m
//  youqinghai
//
//  Created by snailz on 16/3/30.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "ZModifyPhoneViewController.h"
#import "UIViewController+TableView.h"
#import "ZModifyTextCell.h"
#import "RequestBaseAPI+Personal.h"
@interface phoneModel :NSObject
@property(nonatomic,strong)NSString *Oldphone;
@property(nonatomic,strong)NSString *Newphone;
@property(nonatomic,strong)NSString *Codphone;
@property(nonatomic,strong)NSString *serverCod;
@property(nonatomic,strong)NSString *testCod;
@end
@implementation phoneModel



@end
@interface ZModifyPhoneViewController ()
{
    NSInteger seconds;
}
@property(nonatomic,strong)NSMutableArray *cellar;
@property(strong,nonatomic)NSTimer *timer;
@property(strong,nonatomic)phoneModel *phoneModel;
@end

@implementation ZModifyPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _phoneModel = [[phoneModel alloc]init];
    self.view.backgroundColor = spaceColor238238238();
    self.tableView.backgroundColor = [UIColor clearColor];
    _cellar = [NSMutableArray arrayWithObjects:@"", @"",@"",@"",nil];
  self.tableView.tableFooterView =  [self footView];
//   [self.tableView registerNib:[UINib nibWithNibName:@"ZModifyTextCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ZModifyTextCell"];
    // Do any additional setup after loading the view.
}
-(UIView*)footView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"绑定" forState:UIControlStateNormal];
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
    [self.view endEditing:YES];
    for (int i = 0; i<3; i++) {
        ZModifyTextCell *cell = _cellar[i];
        if ([cell.fieldText.text isEqualToString:@""]) {
            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"" message:@"请填写完整的内容" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        
        switch (i) {
            case 0:
            {
                NSString *phoneRegex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0-9]))\\d{8}$";
                NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
                if (![phoneTest evaluateWithObject:cell.fieldText.text]) {
                    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"" message:@"手机格式错误" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                    [alert show];
                    return;
                }
                if (![cell.fieldText.text isEqualToString:[ZUserModel shareUserModel].phone]) {
                    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"" message:@"请输入正确的注册手机号" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                    [alert show];
                    return;
                }
                _phoneModel.Oldphone = cell.fieldText.text;
                
            }
                break;
            case 1:
            {
                NSString *phoneRegex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0-9]))\\d{8}$";
                NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
                if (![phoneTest evaluateWithObject:cell.fieldText.text]) {
                    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"" message:@"手机格式错误" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                    [alert show];
                    return;
                }
                
                _phoneModel.Newphone = cell.fieldText.text;
                
            }
                
                break;
            case 2:
                if (![_phoneModel.testCod isEqualToString:cell.fieldText.text]) {
                    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"" message:@"验证码错误" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                    [alert show];
                    return;
                }
                _phoneModel.serverCod = cell.fieldText.text;
                break;
            default:
                break;
        }
        
    }
    RACSignal *signal = [[RequestBaseAPI standardAPI] userModfPhoneWithuserId:[ZUserModel shareUserModel].userId witholdTel:[ZUserModel shareUserModel].phone withnewTel:_phoneModel.Newphone withcodesms:_phoneModel.serverCod withtype:@"2"];
 __weak ZModifyPhoneViewController *blockSelf =self;
          [signal subscribeNext:^(id x) {
                        NSLog(@"%@",x);
              [ZUserModel shareUserModel].phone = blockSelf.phoneModel.Newphone;
              [blockSelf.navigationController popToRootViewControllerAnimated:YES];
//                        NSDictionary *dic =  [NSJSONSerialization JSONObjectWithData:[((NSString *)x) dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
//                        [[ZUserModel shareUserModel] mj_setKeyValues:dic];
//                        [ZUserModel shareUserModel].passWord = _reqModel.password;
//                        [blockSelf.navigationController popToRootViewControllerAnimated:YES];
//                        NSLog(@"%@",[ZUserModel shareUserModel].phone);
                        //        _reqModel.textCod = dic[@"test code ----> "];
                    }];
                                          
     [signal  subscribeError:^(NSError *error) {
                        NSLog(@"%@",error);
                        NSDictionary *dic = error.userInfo;
                        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"" message:dic[@"message"] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                        [alert show];
                    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

{
    
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZModifyTextCell  *cell =  [[NSBundle mainBundle] loadNibNamed:@"ZModifyTextCell" owner:nil options:nil].firstObject;
    cell.selectionStyle = 0;
    cell.lableText.textColor = [UIColor colorWithRed:0.286 green:0.286 blue:0.298 alpha:1.000];
    switch (indexPath.row) {
        case 0:
        {
            cell.lableText.text = @"原手机号";
            cell.fieldText.placeholder =@"请输入您原来绑定的手机号";
        }
            break;
        case 1:
        {
            cell.lableText.text = @"绑定手机";
            cell.fieldText.placeholder =@"请输入您现在要绑定的手机号码";
        }
            break;
        case 2:
        {
            cell.lableText.text = @"验证码";
            cell.fieldText.placeholder =@"请输入验证码";
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 84, 30)];
            btn.layer.borderWidth = 1;
            btn.layer.borderColor = [UIColor orangeColor].CGColor;
            btn.layer.cornerRadius = 4;
            [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn addTarget:self action:@selector(getCode:) forControlEvents:UIControlEventTouchUpInside];
            cell.fieldText.rightView = btn;
            cell.fieldText.rightViewMode  = UITextFieldViewModeAlways;
            [_cellar setObject:btn atIndexedSubscript:3];
        }
            break;
        default:
            break;
    }
    
    
    
    [_cellar setObject:cell atIndexedSubscript:indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 12;
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
/**
 *  获取验证码
 */
-(void)getCode:(UIButton*)btn
{
    NSLog(@"调用");
    ZModifyTextCell  *cell = _cellar[1];
    NSString *phoneRegex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    if (![phoneTest evaluateWithObject:cell.fieldText.text]) {
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"" message:@"手机格式错误" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    RACSignal *signal = [[RequestBaseAPI standardAPI]phoneWithphone:cell.fieldText.text withtype:@"2" withState:@"0"];
    [signal subscribeNext:^(id x) {
        
        
        NSDictionary *dic =  [NSJSONSerialization JSONObjectWithData:[((NSString *)x) dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        NSLog(@"%@",dic[@"test code ----> "]);
        _phoneModel.testCod = dic[@"test code ----> "];
    }];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAct:) userInfo:btn repeats:YES];
    [_timer fire];
}
-(void)timerAct:(NSTimer*)time
{
    UIButton *btn = time.userInfo;
    btn.userInteractionEnabled=NO;
    if (seconds==0&&![btn.titleLabel.text isEqualToString:@"获取验证码"]) {
        [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
        seconds=0;
        btn.userInteractionEnabled=YES;
        [_timer invalidate];
        _timer = nil;
        return;
    }
    
    if (seconds ==0) {
        [btn setTitle:@"59秒后重发" forState:UIControlStateNormal];
        seconds = 59;
    }else{
        [btn setTitle:[NSString stringWithFormat:@"%ld秒后重发",(long)seconds] forState:UIControlStateNormal];
    }
    
    seconds--;
    
    
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
