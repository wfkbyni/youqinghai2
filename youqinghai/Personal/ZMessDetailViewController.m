//
//  ZMessDetailViewController.m
//  youqinghai
//
//  Created by snailz on 16/4/6.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "ZMessDetailViewController.h"
#import "RequestBaseAPI+Personal.h"
@interface ZMessDetailViewController ()
@property(nonatomic,weak)UILabel* titleLabel;
@property(nonatomic,weak)UILabel* time;
@property(nonatomic,weak)UILabel* contents;
@property(weak,nonatomic)UIScrollView *scrollView;
@end

@implementation ZMessDetailViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息详情";
    self.view.backgroundColor = spaceColor238238238();
   

    
    [self UIBarButton];
    // Do any additional setup after loading the view.
}
-(void)UIBarButton
{
    UIButton *btn             = [[UIButton alloc] init];
    
    [btn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font  = [UIFont systemFontOfSize:14];
    btn.contentMode = UIViewContentModeLeft;
    [btn sizeToFit];
//    CGFloat width = [@"删除" boundingRectWithSize:CGSizeMake(200, 40) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.width;
//    btn.size                  = CGSizeMake(width, 40);
    btn.titleLabel.textAlignment = NSTextAlignmentRight;
    [btn addTarget:self action:@selector(regisPush) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}
/**
 *  删除消息
 */
-(void)regisPush
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    RACSignal *signal = [[RequestBaseAPI standardAPI] userMessDeleteWithmessId:self.messMod.ID];
    __weak ZMessDetailViewController *blockSelf = self;
    [signal subscribeNext:^(id x) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [blockSelf.navigationController popViewControllerAnimated:YES];
    }];
    [signal subscribeError:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    RACSignal *signal = [[RequestBaseAPI standardAPI] messdetailedWithmessId:self.messMod.ID];
     __weak ZMessDetailViewController *blockSelf = self;
    [signal subscribeNext:^(id x) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[((NSString *)x) dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        blockSelf.messMod = [ZUserMessModel mj_objectWithKeyValues:dic];
    }];
    [signal subscribeError:^(NSError *error) {
       [MBProgressHUD hideHUDForView:self.view animated:YES]; 
    }];
}
-(void)initUI
{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    _scrollView =scrollView;
    scrollView.backgroundColor  =[UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 25)];
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor = [UIColor colorWithRed:0.286 green:0.286 blue:0.298 alpha:1.000];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    UILabel* time = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame)+12, self.view.frame.size.width, 20)];
    time.font = [UIFont systemFontOfSize:14];
    time.textColor = [UIColor colorWithWhite:0.702 alpha:1.000];
    time.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:time];
    _time =time;
    
    UILabel* contents = [[UILabel alloc]initWithFrame:CGRectMake(12, CGRectGetMaxY(time.frame)+12, self.view.frame.size.width-24, 20)];
    contents.font = [UIFont systemFontOfSize:16];
    contents.textColor = [UIColor colorWithWhite:0.400 alpha:1.000];
    contents.numberOfLines=0;
    [scrollView addSubview:contents];
    _contents =contents;
    
    
}
-(void)setMessMod:(ZUserMessModel *)messMod{
    _messMod = messMod;
    
    _time.text =messMod.addTime;
    
    CGSize titSize = [messMod.content boundingRectWithSize:CGSizeMake(self.view.frame.size.width-24, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
    _titleLabel.text = messMod.title;
    _contents.frame = CGRectMake(12, _contents.frame.origin.y, titSize.width, titSize.height);
    _contents.text = messMod.content;
    _scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(_titleLabel.frame)+12);

    
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
