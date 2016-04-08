//
//  RedirectViewController.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/24.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "RedirectViewController.h"

@interface RedirectViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *myWebView;
@end

@implementation RedirectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:self.banner.redirect]];
    
    [self.myWebView loadRequest:request];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
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
