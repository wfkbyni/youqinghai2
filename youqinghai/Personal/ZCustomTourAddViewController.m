//
//  ZCustomTourAddViewController.m
//  youqinghai
//
//  Created by snailz on 16/4/6.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "ZCustomTourAddViewController.h"
#import "UIViewController+TableView.h"
#import "RequestBaseAPI+Personal.h"
#import "ZModifyTextCell.h"
#import "ZTextViewCell.h"
@interface CusTomTourModel :NSObject
@property(strong,nonatomic)NSString *contact;
@property(strong,nonatomic)NSString *tel;
@property(strong,nonatomic)NSString *travelTime;
@property(strong,nonatomic)NSString *travelTimeS;
@property(strong,nonatomic)NSString *travelNum;
@property(strong,nonatomic)NSString *origin;
@property(strong,nonatomic)NSString *destination;
@property(strong,nonatomic)NSString *details;

@end
@implementation CusTomTourModel
-(BOOL)notData
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (!propertyValue) {
            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"" message:@"对不起,请完整填写定制旅游信息"delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alert show];
            
            return NO;
        }
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
    }
    
    free(properties);
    return YES;
}


@end
@interface ZCustomTourAddViewController ()
@property(nonatomic,strong)CusTomTourModel *CusTourMod;
@property(weak,nonatomic)UIView *DatePickerView;
@property(weak,nonatomic)ZModifyTextCell *timeCell;
@end

@implementation ZCustomTourAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增定制旅游";
    self.view.backgroundColor = spaceColor238238238();
    _CusTourMod =[[CusTomTourModel alloc]init];
    _CusTourMod.details = @"";
    self.tableView.backgroundColor = [UIColor clearColor];
    
     self.tableView.tableFooterView =  [self footView];
    [self setDatePicker];
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
    [self.view endEditing:YES];
    NSLog(@"%@",self.CusTourMod.contact);
    if (self.CusTourMod.travelNum.integerValue==0) {
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"" message:@"对不起请输入正确的人数"delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        
        return ;
    }
    
    if (![self.CusTourMod notData]) {
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    RACSignal *signal = [[RequestBaseAPI standardAPI ]userCustomWithuserId:[ZUserModel shareUserModel].userId withcontacts:self.CusTourMod.contact withphone:self.CusTourMod.tel withtravelnum:self.CusTourMod.travelNum withtravelTime:self.CusTourMod.travelTimeS withdeparture:self.CusTourMod.origin withdestination:self.CusTourMod.destination withchannelscenicspot:self.CusTourMod.details];
    [signal subscribeNext:^(id x) {
        NSLog(@"x");
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"" message:@"发布成功" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [signal subscribeError:^(NSError *error) {
        NSLog(@"%@",error);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSDictionary *dic = error.userInfo;
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"" message:dic[@"message"] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
    }];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"调用");
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
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZModifyTextCell  *cell =  [[NSBundle mainBundle] loadNibNamed:@"ZModifyTextCell" owner:nil options:nil].firstObject;
    cell.selectionStyle = 0;
    cell.lableText.textColor = [UIColor colorWithRed:0.286 green:0.286 blue:0.298 alpha:1.000];
    
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    cell.lableText.text = @"联系人";
                    cell.fieldText.placeholder = @"请输入联系人";
                
                    cell.TextBlcok = ^(NSString* text){
                        self.CusTourMod.contact = text;
                    };
                }
                    break;
                case 1:
                {
                    cell.lableText.text = @"联系电话";
                    cell.fieldText.placeholder = @"请输入联系电话";
                     cell.fieldText.keyboardType = UIKeyboardTypePhonePad;
                    cell.TextBlcok = ^(NSString* text){
                        self.CusTourMod.tel = text;
                    };
                }
                    break;
                case 2:
                    cell.lableText.text = @"出游时间";
                    cell.fieldText.placeholder = @"请选择出游时间";
                    cell.fieldText.userInteractionEnabled = NO;
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    _timeCell  =cell;
                    break;
                case 3:
                {
                    cell.lableText.text = @"出游人数";
                    cell.fieldText.placeholder = @"请输入出游人数";
                    cell.fieldText.keyboardType = UIKeyboardTypePhonePad;
                    cell.TextBlcok = ^(NSString* text){
                  
                        self.CusTourMod.travelNum = text;
                        
                    };
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
                    cell.fieldText.placeholder = @"请输入旅游出发地";
                    cell.TextBlcok = ^(NSString* text){
                        self.CusTourMod.origin = text;
                    };
                }
                    break;
                case 1:
                {
                    cell.lableText.text = @"旅游目的地";
                    cell.fieldText.placeholder = @"请输入旅游目的地";
                    cell.TextBlcok = ^(NSString* text){
                        self.CusTourMod.destination = text;
                    };
                }
                    break;
                case 2:
                {
                    ZTextViewCell   *cell =  [[NSBundle mainBundle] loadNibNamed:@"ZTextViewCell" owner:nil options:nil].firstObject;
                    
                    cell.TextBlcok = ^(NSString *text)
                    {
                        self.CusTourMod.details = text;
                    };
                    return cell;
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
    if (indexPath.section==1&&indexPath.row==2) {
        return 140;
    }
    return  44;
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
    if (indexPath.section==0&&indexPath.row ) {
 
        [self.view endEditing:YES];
        _DatePickerView.hidden=NO;
    }

}
-(void)setDatePicker
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-246, self.view.frame.size.width, 246)];
    view.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    UIDatePicker *datePicker = [ [ UIDatePicker alloc] initWithFrame:CGRectMake(0.0,30,0.0,0.0)];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.minuteInterval = 5;
    NSDate* minDate = [NSDate dateWithTimeIntervalSinceNow:0];;
    NSDate* maxDate = [NSDate dateWithTimeIntervalSinceNow:3600*365*80];
    NSDate* nowDate = [NSDate dateWithTimeIntervalSinceNow:0];
    datePicker.minimumDate = minDate;
    datePicker.maximumDate = maxDate;
    datePicker.date = nowDate;
    [datePicker setDate:nowDate animated:YES];
    [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];
    [view addSubview:datePicker];
    
    UIButton *send = [UIButton buttonWithType:UIButtonTypeSystem];
    [send setTitle:@"确定" forState:UIControlStateNormal];
    [send setTitleColor:[UIColor colorWithRed:0.286 green:0.286 blue:0.298 alpha:1.000] forState:UIControlStateNormal];
    [send addTarget:self action:@selector(btnAct:) forControlEvents:UIControlEventTouchUpInside];
    send.tag = 10;
    send.frame = CGRectMake(self.view.frame.size.width-52, 0, 40, 30);
    [view addSubview:send];
    
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel setTitleColor:[UIColor colorWithRed:0.671 green:0.667 blue:0.675 alpha:1.000] forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(btnAct:) forControlEvents:UIControlEventTouchUpInside];
    cancel.tag = 11;
    cancel.frame = CGRectMake(12, 0, 40, 30);
    [view addSubview:cancel];
    
    [self.view addSubview:view];
    _DatePickerView = view;
    view.hidden=YES;
}
-(void)btnAct:(UIButton*)btn
{
    if (btn.tag==10) {
        
    }else{
     self.CusTourMod.travelTime =@"";
        self.CusTourMod.travelTimeS = @"";
          self.timeCell.fieldText.text =self.CusTourMod.travelTime ;
    }
    self.DatePickerView.hidden =YES;
}
-(void)dateChanged:(id)sender{
    UIDatePicker* control = (UIDatePicker*)sender;
    NSDate* _date = control.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"y-M-d "];

    self.CusTourMod.travelTime = [dateFormatter stringFromDate:_date];
    self.timeCell.fieldText.text =self.CusTourMod.travelTime ;
    self.CusTourMod.travelTimeS = @([_date timeIntervalSince1970]*1000).stringValue;
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
