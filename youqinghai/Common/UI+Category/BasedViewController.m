//
//  BasedViewController.m
//  FCHealthy
//
//  Created by mouxiaochun on 16/2/18.
//  Copyright © 2016年 mmc. All rights reserved.
//

#import "BasedViewController.h"

@implementation BasedViewController
- (void)viewDidLoad {

    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = self.leftBarItem;
}

- (UIBarButtonItem *) leftBarItem {

    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:@"go_back"];
    [bt setImage:image forState:UIControlStateNormal];
    [bt setImage:[UIImage imageNamed:@"go_back_active"] forState:UIControlStateHighlighted];
    bt.frame = (CGRect){0,0,image.size};
    [bt addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:bt];

    return item;
}

- (void) goback {

    [self.navigationController popViewControllerAnimated:YES];
}
@end
