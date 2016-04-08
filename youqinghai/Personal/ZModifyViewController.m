//
//  ZModifyViewController.m
//  youqinghai
//
//  Created by snailz on 16/3/30.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "ZModifyViewController.h"
#import "UIViewController+TableView.h"
#import "ZModifyTextCell.h"
@interface ZModifyViewController ()
@property(nonatomic,strong)ZModifyTextCell *cell;
@end

@implementation ZModifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = spaceColor238238238();
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZModifyTextCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ZModifyTextCell"];
    self.tableView.tableFooterView =  [self footView];
    // Do any additional setup after loading the view.
}
-(UIView*)footView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor redColor]];
    button.layer.cornerRadius = 4;
    [button addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(12, 20, self.view.frame.size.width-24, 40);
    [view addSubview:button];
    return view;
}
-(void)save
{
    
    if ([self.cell.fieldText.text isEqualToString:@""]) {
        UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入您要修改的内容" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alter show];
        return;
    }
    [self.view endEditing:YES];
    if ([self.title isEqualToString:@"修改昵称"]) {
        [ZUserModel shareUserModel].nickname = self.cell.fieldText.text;
    }else{
        [ZUserModel shareUserModel].autograph = self.cell.fieldText.text;
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"modifyUser" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

{
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
     ZModifyTextCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"ZModifyTextCell"];
    cell.selectionStyle = 0;
    cell.lableText.text = self.textName;
    cell.fieldText.placeholder = self.fieldName;
    _cell = cell;
   
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
    return  44;
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
