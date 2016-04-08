//
//  UIView+Helper.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/23.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "UIView+Helper.h"

@implementation UIView (Helper)

-(void)viewWithCornerRadius:(NSInteger)cornerRadius{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

-(void)viewWithBorderWidth:(NSInteger)borderWidth WithBorderColor:(UIColor *)borderColor{
    self.layer.borderColor = [borderColor CGColor];
    self.layer.borderWidth = borderWidth;
    self.layer.masksToBounds = YES;
}

- (UIImage *)clipImage:(UIImage *)image toSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, YES, [UIScreen mainScreen].scale);
    
    CGSize imgSize = image.size;
    CGFloat x = MAX(size.width / imgSize.width, size.height / imgSize.height);
    CGSize resultSize = CGSizeMake(x * imgSize.width, x * imgSize.height);
    
    [image drawInRect:CGRectMake(0, 0, resultSize.width, resultSize.height)];
    
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return finalImage;
}
@end
