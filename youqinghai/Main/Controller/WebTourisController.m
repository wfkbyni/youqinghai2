//
//  WebTourisController.m
//  youqinghai
//
//  Created by 舒永超 on 16/4/27.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "WebTourisController.h"

@interface WebTourisController ()
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;

@end

@implementation WebTourisController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"景点详情";
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.sinata.cn:9402/swimQinghai/app/touristroutes/linesdetail?id=%ld",_tourismId]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.myWebView loadRequest:request];
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
