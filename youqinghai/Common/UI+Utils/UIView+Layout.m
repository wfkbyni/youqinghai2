//
//  UIView+Layout.m
//  CMCC-JiFen
//
//  Created by mouxiaochun on 15/5/22.
//  Copyright (c) 2015年 MacMini. All rights reserved.
//

#import "UIView+Layout.h"
@implementation UIImage (XY)

- (CGFloat) width {

    return self.size.width;
}
- (CGFloat) height {

    return self.size.height;
}


@end
@implementation UIView(Layout)
//y坐标
-(CGFloat) y{

    return CGRectGetMinY (self.frame);
}

//x坐标
-(CGFloat) x{
    return CGRectGetMinX(self.frame);
}

//width
-(CGFloat) width
{

    return CGRectGetWidth(self.frame);
}

//height
-(CGFloat)height{

    return CGRectGetHeight(self.frame);
}

- (CGSize) size {

    return self.frame.size;
}

#pragma mark ---- 相对位置

-(CGFloat)relativeX{
    
    CGFloat x = self.x + self.width;
    return x;
}

-(CGFloat)relativeY{
    
    CGFloat y = self.y + self.height;
    return y;
}

- (CGFloat)centerX
{
    return self.center.x;
}
- (CGFloat)centerY
{
    return self.center.y;
}
#pragma mark ---
-(void)setOrigin:(CGPoint)origin{
    
    CGRect f  = self.frame;
    if (![NSStringFromCGPoint(origin) isEqualToString:NSStringFromCGPoint(f.origin)]) {
        f.origin = origin;
        self.frame = f;
    }
}

-(void)setSize:(CGSize)size{

    CGRect f  = self.frame;
    if (![NSStringFromCGSize(size) isEqualToString:NSStringFromCGSize(f.size)]) {
        f.size = size;
        self.frame = f;
    }
}

-(void)setWidth:(CGFloat)width{

    CGRect f  = self.frame;
    if (width != f.size.width) {
        f.size.width = width;
        self.frame = f;
    }
}

-(void)setHeight:(CGFloat)height{

    CGRect f  = self.frame;
    if (height != f.size.height) {
        f.size.height = height;
        self.frame = f;
    }
}

-(void)setX:(CGFloat)x{
    CGRect f  = self.frame;
    if (x != f.origin.x) {
        f.origin.x = x;
        self.frame = f;
    }
}
-(void)setY:(CGFloat)y{
    CGRect f  = self.frame;
    if (y != f.origin.y) {
        f.origin.y = y;
        self.frame = f;
    }
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    if(center.x != centerX)
    {
        center.x = centerX;
        self.center = center;
    }
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    if(center.y != centerY)
    {
        center.y = centerY;
        self.center = center;
    }
}


-(void) floatHeight:(CGFloat)fHeight{

    CGRect frame = self.frame;
    frame.size.height += fHeight;
    [self setFrame:frame];
}

-(void) floatHeightByScreen:(CGFloat)fHeight{

    CGRect f = [[UIScreen mainScreen] bounds];
    f.size.height = self.height+fHeight;
    self.frame = f;
}





@end


@implementation NSObject(line)

- (CALayer *)seperatorline {
    CALayer *line = [[CALayer alloc] init];
    UIColor *color = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0];
    line.backgroundColor = color.CGColor;
    return line;
}
- (CGFloat) rateOfW {
    
    return (Screen.width / 375.0);
}

- (CGFloat) rateOfH {
    
    return (Screen.height / 667.0);
}
- (BOOL) iphone6p  {
    
    if  (Screen.width > 375.0)
        return YES;
    return NO;
}

- (BOOL) iphone6  {
    
    if  (Screen.width == 375.0)
        return YES;
    return NO;
}

- (BOOL) iphone4s {
    if  (Screen.height == 480.0)
        return YES;
    return NO;
}

- (BOOL) iphone5s {
    if  (Screen.height == 568.0)
        return YES;
    return NO;
}

- (BOOL) isLowerThanIphone6 {
    if  (Screen.width < 375.0)
        return YES;
    return NO;
}

- (CGFloat) viewOfHeight {

    if (self.iphone6p) {
        return 240;
    }
    if (self.iphone5s) {
        return 215;
    }
    if (self.iphone4s) {
        return 215;
    }
    return 230;
}

@end
@implementation Screen : NSObject

+ (CGRect) bounds {

    return [[UIScreen mainScreen] bounds];
}
+ (CGSize) size {

    return self.bounds.size;
}

+ (CGFloat) width {

   return Screen.size.width;
}
+ (CGFloat) height {

    return Screen.size.height;
}



@end


