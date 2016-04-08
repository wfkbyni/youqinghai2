//
//  TourismDetailView.h
//  youqinghai
//
//  Created by 舒永超 on 16/3/27.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LeftViewModel) {
    LeftViewModelTop,       // 上
    LeftViewModelCenter,    // 中
    LeftViewModelBottom     // 下
};

@interface TourismDetailView : UIScrollView

@property (nonatomic, strong) NSArray *viewlist;

@end
