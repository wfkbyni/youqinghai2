//
//  ZPersonalDataViewController.m
//  youqinghai
//
//  Created by snailz on 16/3/29.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "ZPersonalDataViewController.h"
#import "ZUserModel.h"
#import "UIViewController+TableView.h"
#import "RequestBaseAPI+Personal.h"
#import "ZModifyViewController.h"
#import "ZAccountSecurityViewController.h"
@interface headerUrl : NSObject
@property(nonatomic,copy)NSString *headUrl;
@end
@implementation headerUrl



@end
@interface ZPersonalDataViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)ZUserModel *userModel;
@property(weak,nonatomic)UIActionSheet *photoSheet;
@property(weak,nonatomic)UIActionSheet *sexSheet;
@end

@implementation ZPersonalDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人资料";
    self.view.backgroundColor = spaceColor238238238();
    self.tableView.backgroundColor = [UIColor clearColor];
    _userModel =  [ZUserModel shareUserModel];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(modifyUserInfo) name:@"modifyUser" object:nil];
    //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    // Do any additional setup after loading the view.
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"退出");
}
#pragma mark - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

{
    if (section==1) {
        return 1;
    }
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
  //  UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
      UITableViewCell*  cell = [[ UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.textLabel.textColor = [UIColor lightGrayColor];
        cell.detailTextLabel.textColor = [UIColor colorWithRed:0.286 green:0.286 blue:0.298 alpha:1.000];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"头像";
            {

                UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-110, 10, 80, 80)];
                [view sd_setImageWithURL:[NSURL URLWithString:self.userModel.headUrl] placeholderImage:[UIImage imageNamed:@"userhead"]];
                view.layer.cornerRadius =view.bounds.size.height/2;
                view.contentMode = UIViewContentModeScaleAspectFill;
                view.clipsToBounds = YES;
                [cell addSubview:view];
            }
                return cell;
                break;
            case 1:
                cell.textLabel.text = @"昵称";
                cell.detailTextLabel.text = self.userModel.nickname;
                return cell;
                break;
            case 2:
                cell.textLabel.text = @"性别";
                cell.detailTextLabel.text = self.userModel.sex.integerValue?@"男":@"女";
               
                return cell;
                break;
            case 3:
                cell.textLabel.text = @"签名";
                cell.detailTextLabel.text = self.userModel.autograph;
                return cell;
                break;
            case 4:
                cell.textLabel.text = @"账号安全";
                return cell;
                break;
            default:
                break;
        }
    }
    
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.accessoryType = UITableViewCellAccessoryNone;
    UILabel *text = [[UILabel alloc]init];
    text.text = @"退出登录";
    text.textColor = [UIColor lightGrayColor];
    [text sizeToFit];
    text.center = CGPointMake(self.view.frame.size.width/2, 44/2);
    [cell addSubview:text];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return  10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (indexPath.section==0&&indexPath.row==0) {
        return 100;
    }
    return  44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
   
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 0:
            {
                UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                              initWithTitle:@"修改头像"
                                              delegate:self
                                              cancelButtonTitle:@"取消"
                                              destructiveButtonTitle:nil
                                              otherButtonTitles:@"相册", @"拍照",nil];
                actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
                [actionSheet showInView:self.view];
                _photoSheet = actionSheet;
            }
                break;
            case 1:
            {
                ZModifyViewController* modView = [[ZModifyViewController alloc]init];
                modView.title = @"修改昵称";
                modView.textName = @"我的昵称";
                modView.fieldName = @"请输入您的新昵称";
                [self.navigationController pushViewController:modView animated:YES];
            }
                break;
            case 2:
            {
                UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                              initWithTitle:@"修改性别"
                                              delegate:self
                                              cancelButtonTitle:@"取消"
                                              destructiveButtonTitle:nil
                                              otherButtonTitles:@"女", @"男",nil];
                actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
                [actionSheet showInView:self.view];
                _sexSheet = actionSheet;
            }
                break;
            case 3:
            {
                ZModifyViewController* modView = [[ZModifyViewController alloc]init];
                modView.title = @"修改签名";
                modView.textName = @"我的签名";
                modView.fieldName = @"请输入您的新签名";
                [self.navigationController pushViewController:modView animated:YES];
            }
                break;
            case 4:
            {
                ZAccountSecurityViewController *asv = [[ZAccountSecurityViewController alloc]init];
                [self.navigationController pushViewController:asv animated:YES];
            }
            default:
                break;
        }
    }else{
        [ZUserModel shareUserModel].userId = nil;
         [ZUserModel shareUserModel].phone = nil;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    // 下面这几行代码是用来设置cell的上下行线的位置
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 20, 0, 20)];
    }
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==2) {
        return;
    }
    if (actionSheet ==_photoSheet) {
        NSLog(@"%ld",(long)buttonIndex);
        

        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        
        picker.sourceType = buttonIndex;
        
        picker.delegate = self;
        
        
        picker.allowsEditing = YES;
        
        
        [self presentViewController:picker animated:YES completion:nil];

    }
    if (actionSheet == _sexSheet) {
        self.userModel.sex =@(buttonIndex).stringValue;
        [self modifyUserInfo];
        [self.tableView reloadData];
    }
}
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    __block UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    if (!image){
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    __weak ZPersonalDataViewController* blockSelf = self;
 
    
   
    RACSignal *signal = [[RequestBaseAPI standardAPI]ImageHeaderDataWithData:UIImageJPEGRepresentation(image, 0.5)];
    [signal subscribeNext:^(id x) {
        NSLog(@"%@",x);
        headerUrl *dic = [headerUrl mj_objectWithKeyValues:x];
       blockSelf.userModel.headUrl =dic.headUrl;
        [blockSelf.tableView reloadData];
    }];
   
    
    
}
-(void)modifyUserInfo
{
    RACSignal *signal = [[RequestBaseAPI standardAPI]userInfoWithNickName:self.userModel.nickname withSex:self.userModel.sex withAutograph:self.userModel.autograph];
    [signal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
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
