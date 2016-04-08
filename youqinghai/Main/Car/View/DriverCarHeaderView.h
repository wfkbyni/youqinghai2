//
//  DriverCarHeaderView.h
//  youqinghai
//
//  Created by 舒永超 on 16/4/4.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BtnClickEvent) {
    BtnClickEventWithBack,          // 返回
    BtnClickEventWithCollection     // 收藏
};


@interface DriverCarHeaderView : UIView

@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, copy) void (^BtnClickEvent)(BtnClickEvent event);

- (void)bindData:(CarDetail *)carDetail;

@end
