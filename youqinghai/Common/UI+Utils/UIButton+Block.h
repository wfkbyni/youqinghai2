//
//  UIButton+JFBlock.h
//  CMCC-JiFen
//
//  Created by mouxiaochun on 15/5/29.
//  Copyright (c) 2015年 MacMini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Block)

@property(copy, nonatomic) void(^handleJFEventBlock)(UIButton *sender);


@end
