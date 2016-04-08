//
//  BaseViewController.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/20.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController
-(id)init{
    self = [super init];
    if (self) {
        [self initNavigation];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
}
-(void)initNavigation
{
    UIButton *leftBT = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image;
    image = [UIImage imageNamed:@"首页_线路分类_03"];
    [leftBT setImage:image forState:UIControlStateNormal];
    CGRect f ;
    f.size = image.size;
    f.origin.y = 0;
    f.origin.x = 0;
    [leftBT setFrame: f];
    [leftBT addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:leftBT];
    self.navigationItem.leftBarButtonItem = item;
 
}

- (void)popViewController
{
   
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self setEditing:YES];
}
 
@end
