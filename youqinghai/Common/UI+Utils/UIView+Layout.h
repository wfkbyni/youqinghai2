//
//  UIView+Layout.h
//  CMCC-JiFen
//
//  Created by mouxiaochun on 15/5/22.
//  Copyright (c) 2015年 MacMini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XY)

- (CGFloat) width;
- (CGFloat) height;


@end

@interface UIView(Layout)
//y坐标
-(CGFloat) y;

//x坐标
-(CGFloat) x;

//width
-(CGFloat) width;

//height
-(CGFloat) height;
- (CGSize) size;
#pragma mark - 

-(CGFloat) relativeX;
-(CGFloat) relativeY;

#pragma mark ---
-(void) setOrigin:(CGPoint)origin;
-(void) setSize:(CGSize)size;
-(void) setWidth:(CGFloat)width;
-(void) setHeight:(CGFloat)height;
-(void) setX:(CGFloat)x;
-(void) setY:(CGFloat)y;

-(void) floatHeight:(CGFloat)fHeight;

-(void) floatHeightByScreen:(CGFloat)fHeight;

@end


@interface NSObject (line)

- (CALayer *)seperatorline;
- (CGFloat) rateOfW;
- (CGFloat) rateOfH;

- (BOOL) iphone6p;
- (BOOL) iphone6;
- (BOOL) iphone4s;
- (BOOL) iphone5s;
- (BOOL) isLowerThanIphone6;
- (CGFloat) viewOfHeight ;

@end

@interface Screen : NSObject
+ (CGRect) bounds;
+ (CGSize) size;
+ (CGFloat) width;
+ (CGFloat) height;



@end



