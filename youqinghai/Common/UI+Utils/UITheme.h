//
//  NSObject+UITheme.h
//  FCHealthy
//
//  Created by mouxiaochun on 16/2/1.
//  Copyright © 2016年 mmc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIView+Layout.h"

@interface UITheme : NSObject

#pragma mark -- 主题颜色

UIColor * navigatorColor();
UIColor * grayTextColor() ;
UIColor * spaceColor238238238();

#pragma mark --- Font

UIFont * fontSystem11();
UIFont * fontSystem12();
UIFont * fontSystem13();
UIFont * fontSystem14();
UIFont * fontSystem15();
UIFont * fontSystem16();


@end




@interface NSString (att)
- (NSMutableAttributedString *) changeText:(NSString *)string forColor:(UIColor *)color;

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
@end