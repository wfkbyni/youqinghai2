//
//  ZLoginViewController.m
//  youqinghai
//
//  Created by snailz on 16/4/5.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "ZLoginViewController.h"
#import "UIViewController+TableView.h"
#import "ZImageFidCell.h"
#import "RequestBaseAPI+User.h"
#import "ZRegisteredViewController.h"
#import "ZForgetPassViewController.h"
@interface LoginModel :NSObject
@property(nonatomic,strong)NSString *phone;

@property(nonatomic,strong)NSString *password;

@end
@implementation LoginModel



@end
@interface ZLoginViewController ()
@property(strong,nonatomic)LoginModel *loginMod;
@property(nonatomic,strong)NSMutableArray *cellar;
@end

@implementation ZLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    _loginMod = [[LoginModel alloc]init];
    self.view.backgroundColor = spaceColor238238238();
    self.tableView.backgroundColor = [UIColor clearColor];
    _cellar = [NSMutableArray arrayWithObjects:@"", @"",nil];
     self.tableView.tableFooterView =  [self footView];
    [self UIBarButton];
    // Do any additional setup after loading the view.
}
-(void)UIBarButton
{
    UIButton *btn             = [[UIButton alloc] init];
    [btn setTitle:@"注册" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font  = [UIFont systemFontOfSize:14];
    btn.contentMode = UIViewContentModeLeft;
    CGFloat width = [@"注册" boundingRectWithSize:CGSizeMake(200, 40) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.width;
    btn.size                  = CGSizeMake(width, 40);
    btn.titleLabel.textAlignment = NSTextAlignmentRight;
    [btn addTarget:self action:@selector(regisPush) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}
-(UIView*)footView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
    
    
    
    UIButton *passBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [passBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [passBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    passBtn.titleLabel.font = [UIFont systemFontOfSize:13];
 
    [passBtn addTarget:self action:@selector(passWordPush) forControlEvents:UIControlEventTouchUpInside];
    [passBtn sizeToFit];
    passBtn.frame = CGRectMake(view.frame.size.width-passBtn.frame.size.width-12,-12,  passBtn.frame.size.width, passBtn.frame.size.height);
    [view addSubview:passBtn];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"确认登录" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor redColor]];
    button.layer.cornerRadius = 4;
    [button addTarget:self action:@selector(regis) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(12, view.frame.size.height-80, self.view.frame.size.width-24, 40);
    [view addSubview:button];
    return view;
}
-(void)regisPush
{
    ZRegisteredViewController *reg = [[ZRegisteredViewController alloc]init];
    [self.navigationController pushViewController:reg animated:YES];
}
-(void)passWordPush
{
    ZForgetPassViewController *fpv = [[ZForgetPassViewController alloc]init];
    [self.navigationController pushViewController:fpv animated:YES];
}
-(void)regis
{
    [self.view endEditing:YES];
    for (int i = 0; i<2; i++) {
        ZImageFidCell *cell = _cellar[i];
        if ([cell.fieText.text isEqualToString:@""]) {
            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"" message:@"请填写完整的内容" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        switch (i) {
            case 0:
            {
                NSString *phoneRegex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0-9]))\\d{8}$";
                NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
                if (![phoneTest evaluateWithObject:cell.fieText.text]) {
                    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"" message:@"手机格式错误" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                    [alert show];
                    return;
                }
                _loginMod.phone = cell.fieText.text;
            }
                break;
            case 1:
            {
                _loginMod.password = cell.fieText.text;
            }
                break;
            default:
                break;
        }
    }
        __weak ZLoginViewController *BlockSelf = self;
    RACSignal *signal = [[ZUserModel shareUserModel] getUserDataWithPhone:_loginMod.phone andPassWord:_loginMod.password];
    [signal subscribeNext:^(id x) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [BlockSelf.navigationController popToRootViewControllerAnimated:YES];
        });
    }];
//    RACSignal *signal =  [[RequestBaseAPI standardAPI] userLoginWithPhone:_loginMod.phone withPassWord:_loginMod.password];
//    [signal subscribeNext:^(id x) {
//        NSLog(@"%@",x);
//        ZUserModel *userModel = [ZUserModel mj_objectWithKeyValues:x];
//        [ZUserModel shareUserModel].phone = userModel.phone;
//        [ZUserModel shareUserModel].parise = userModel.parise;
//        [ZUserModel shareUserModel].sex = userModel.sex;
//        [ZUserModel shareUserModel].travelCount = userModel.travelCount;
//        [ZUserModel shareUserModel].autograph = userModel.autograph;
//        [ZUserModel shareUserModel].nickname = userModel.nickname;
//        [ZUserModel shareUserModel].userId = userModel.userId;
//        [ZUserModel shareUserModel].headUrl = userModel.headUrl;
//        [ZUserModel shareUserModel].collection = userModel.collection;
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    }];
   [signal subscribeError:^(NSError *error) {
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
    
    return 2;
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
    ZImageFidCell  *cell =  [[NSBundle mainBundle] loadNibNamed:@"ZImageFidCell" owner:nil options:nil].firstObject;
    cell.selectionStyle = 0;
    switch (indexPath.row) {
        case 0:
        {
            cell.icon.image = [UIImage imageNamed:@"登录_03"];
            cell.fieText.placeholder =@"请输入手机号";
            cell.fieText.keyboardType = UIKeyboardTypePhonePad;
        }
            break;
        case 1:
        {
            cell.icon.image = [UIImage imageNamed:@"登录_07"];
            cell.fieText.placeholder =@"请输入密码";
            cell.fieText.keyboardType = UIKeyboardTypeNumberPad;
            cell.fieText.secureTextEntry = YES;
        }
            break;
        default:
            break;
    }
    [_cellar setObject:cell atIndexedSubscript:indexPath.row];
    return cell;
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
