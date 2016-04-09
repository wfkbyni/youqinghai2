//
//  ZPersanalHeaderView.h
//  youqinghai
//
//  Created by snailz on 16/3/28.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^btnBlock)(int type);
@interface ZPersanalHeaderView : UIView
@property(weak,nonatomic)UIViewController *viewController;
@property(strong,nonatomic)btnBlock btnBlcok;
-(void)setData;
@end
