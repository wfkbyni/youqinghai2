//
//  CheckBoxView.h
//  youqinghai
//
//  Created by 舒永超 on 16/4/5.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger ,CheckBoxBtnVeiw) {
    CheckBoxVeiwWithNO,
    CheckBoxVeiwWithYES
};

@interface CheckBoxView : UIView

@property (nonatomic, assign) BOOL checked;

@end
