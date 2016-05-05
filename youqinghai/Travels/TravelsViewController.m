//
//  TravelsViewController.m
//  QingHaiTourClient
//
//  Created by mouxiaochun on 16/3/12.
//  Copyright © 2016年 mmc. All rights reserved.
//

#import "TravelsViewController.h"
#import "TravelCell.h"
#import "AIWebViewLoadRequest.h"
#import "AIHybridJSParam.h"
#import "TravelsViewModel.h"

#import "AINavigationController.h"
#import "PublishTravelsController.h"

#import "KMMessagView.h"

@interface TravelsViewController(){
    KMMessagView *messagebox;
}
@end

@implementation TravelsViewController

- (void)loadView {

    [super loadView];
    
}

- (void)viewDidLoad {

    [super viewDidLoad];
    self.view.backgroundColor = spaceColor238238238();
     self.title = @"游记";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(myAction:)];
    
    self.view.webView.fileURL =  @"JSNativeInteractive.html" ;//@"travels.html";
     self.view.webView.webviewLoadType = HybridWebViewLoadType_Local;
     [self.view.webView loadURLRequest];
    
    TravelsViewModel *viewModel = [[TravelsViewModel alloc] init];
    
    CGSize size=[UIScreen mainScreen].bounds.size;
    CGRect boxFrame=CGRectMake(0,size.height, size.width, 45);
    messagebox=[[KMMessagView alloc]initWithFrame:boxFrame PlaceText:@"评论" PlaceColor:[UIColor lightGrayColor]];
    [messagebox sendMessage:^(NSString *txt) {
        NSLog(@"%@",txt);
        [[viewModel commentTravelsWithTravelId:0 withComContent:txt] subscribeNext:^(id x) {
            
        } error:^(NSError *error) {
            
        }];
    }];
    [self.view addSubview:messagebox];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [messagebox.inputView resignFirstResponder];
}

- (void)myAction:(id)sender{
    PublishTravelsController *controller = [[PublishTravelsController alloc] init];
    
    AINavigationController *nav = [[AINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
