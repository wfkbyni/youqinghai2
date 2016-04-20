//
//  ZCWhyViewController.h
//  youqinghai
//
//  Created by snailz on 16/4/20.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^selectBlock)(NSString*);
@interface ZCWhyViewController : BaseViewController
@property(strong,nonatomic)selectBlock selectBlock;
@end
