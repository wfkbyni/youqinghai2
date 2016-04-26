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

#import "AINavigationController.h"
#import "PublishTravelsController.h"

@implementation TravelsViewController

- (void)loadView {

    [super loadView];
    
}

- (void)viewDidLoad {

    [super viewDidLoad];
    self.view.backgroundColor = spaceColor238238238();
     self.title = @"游记";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(myAction:)];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"travels" withExtension:@"html" subdirectory:@"html"];
    [self.webView loadRequestWithURL:url];
    
}

- (void)myAction:(id)sender{
    PublishTravelsController *controller = [[PublishTravelsController alloc] init];
    
    AINavigationController *nav = [[AINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
