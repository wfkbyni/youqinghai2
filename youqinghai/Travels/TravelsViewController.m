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

@implementation TravelsViewController

- (void)loadView {

    [super loadView];
    
 }

- (void)viewDidLoad {

    [super viewDidLoad];
    self.view.backgroundColor = spaceColor238238238();
     self.title = @"游记";
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"travels" withExtension:@"html" subdirectory:@"html"];
    [self.webView loadRequestWithURL:url];
}



@end
