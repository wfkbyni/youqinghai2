//
//  ZOpinionViewController.m
//  youqinghai
//
//  Created by snailz on 16/4/10.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "ZOpinionViewController.h"
#import "RequestBaseAPI+Personal.h"
#import "ZTextViewCell.h"
@interface ZOpinionViewController ()

@end

@implementation ZOpinionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    self.images = [NSMutableArray array];
    self.height  = imageViewH+ImageH+12 ;
    self.view.backgroundColor = spaceColor238238238();
    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.tableView.tableFooterView =  [self footView];
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
    if (!self.str.length) {
        UIAlertView *av= [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入内容" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [av show];
        return;
    }
    
    RACSignal *signal = [[RequestBaseAPI standardAPI] addFeedBackWithData:self.images andText:self.str];
    [signal subscribeNext:^(id x) {
        NSLog(@"%@",x);
        UIAlertView *av= [[UIAlertView alloc]initWithTitle:@"提示" message:@"反馈成功,感谢您提供的意见" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [av show];
        [self.navigationController popViewControllerAnimated:YES];
    }];
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
    ZTextViewCell   *cell =  [[NSBundle mainBundle] loadNibNamed:@"ZTextViewCell" owner:nil options:nil].firstObject;
    cell.controller =self;
    cell.images = self.images;
    cell.placeholder.text = @"用的不爽,说两句,最多200字";
    cell.photo = @"";
    cell.textViewheight.constant = 145;
    
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
    return 12;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
 
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
