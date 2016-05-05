//
//  AINavigationBar.m
//  AINavigationBar
//
//  Created by mouxiaochun on 15/8/20.
//  Copyright (c) 2015年 mouxiaochun. All rights reserved.
//

#import "AINavigationBar.h"
#import <objc/runtime.h>
#import "UIButton+WebCache.h"
#define WeakPointer(weakSelf) __weak __typeof(&*self)weakSelf = self

@implementation NSObject (Hex)

- (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

//默认alpha值为1
- (UIColor *) hexForColor:(NSString *)color
{
    return [self colorWithHexString:color alpha:1.0f];
}

@end

static NSString * key_EventBlock = @"key_EventBlock";

@interface UIButton (Event)

@property(copy, nonatomic) void(^handleJFEventBlock)(UIButton *sender);

@end

@implementation UIButton (Event)

-(IBAction)eventHandler
{
    
    if (self.handleJFEventBlock) {
        self.handleJFEventBlock(self);
    }
}
#pragma mark - block
-(void)setHandleJFEventBlock:(void (^)(UIButton *sender))eventBlock{
    
    objc_setAssociatedObject(self, (__bridge const void *)key_EventBlock, eventBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    if (eventBlock) {
        
        [self addTarget:self action:@selector(eventHandler) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void (^) (UIButton *)) handleJFEventBlock{
    return objc_getAssociatedObject(self, (__bridge const void *)key_EventBlock);
}


@end


@implementation UIViewController (navigation)


/**
 *  设置页面标题
 *
 *  @param title 标题
 */
- (void)setPageTitle:(NSString *)title {

    self.navigationItem.title = title;
}

/**
 *  设置左侧返回按钮
 */
- (void)setBackBarItem{
    [self setTextBarItem:@"返回" direction:TopBarItemDirectionLeft];
}

/**
 *  设置导航栏的文本按钮
 *
 *  @param barItemTitle 按钮文本,文字颜色默认为 darkTextColor
 *  @param direction    左/右侧
 */
- (void)setTextBarItem:(NSString *)barItemTitle direction:(TopBarItemDirection)direction {
    [self setTextBarItem:barItemTitle direction:direction font:0 color:nil];
}

- (void)setTextBarItem:(NSString *)barItemTitle direction:(TopBarItemDirection)direction font:(CGFloat)fontSize color:(NSString *)color{
    UIButton *button = [self buttonCreator:direction];
    [button setTitle:barItemTitle forState:UIControlStateNormal];
    button.frame = (CGRect){CGPointZero,40,40};
    if (fontSize == 0) {
        fontSize = 14;
    }
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    if (color.length > 0) {
        UIColor *c = [self hexForColor:color];
        [button setTitleColor:c forState:UIControlStateNormal];
    }else
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    if (direction == TopBarItemDirectionLeft) {
        self.navigationItem.leftBarButtonItem = item;
    }else{
        self.navigationItem.rightBarButtonItem = item;
    }
}


/**
 *  设置导航栏的图片按钮
 *
 *  @param barItemImage 图片名称
 *  @param direction    左/右侧
 */
- (void)setImageBarItem:(NSString *)barItemImage direction:(TopBarItemDirection)direction {
    WeakPointer(weakSelf);
    dispatch_async(dispatch_get_main_queue(),^{
        UIButton *button = [weakSelf buttonCreator:direction];
        NSURL *url = [NSURL URLWithString:barItemImage];
        [button sd_setImageWithURL:url forState:UIControlStateNormal];
        button.imageView.contentMode = UIViewContentModeScaleAspectFill;
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
        if (direction == TopBarItemDirectionLeft) {
            weakSelf.navigationItem.leftBarButtonItem = item;
        }else{
            weakSelf.navigationItem.rightBarButtonItem = item;
        }
    });
   
}


- (void)setTextBarItem:(NSDictionary *)jsParam {

    NSString *barItemTitle = jsParam[@"barItemTitle"];
    int direction    = [[jsParam valueForKey:@"direction"] intValue];
    CGFloat fontSize = [[jsParam valueForKey:@"fontSize"] floatValue];
    NSString *color  = [jsParam valueForKey:@"color"];
    [self setTextBarItem:barItemTitle direction:direction font:fontSize color:color];
    
}
- (void)setImageBarItem:(NSDictionary *)jsParam {

    NSString *barItemImage = jsParam[@"barItemImage"];
    int direction = [[jsParam valueForKey:@"direction"] intValue];
    [self setImageBarItem:barItemImage direction:direction];
}

/**
 *  点击左按钮
 */
- (void)leftBarItemEvent {
    [self sendActionForBarItem:TopBarItemDirectionLeft];
}

/**
 *  点击右按钮
 */
- (void)rightBarItemEvent {
    [self sendActionForBarItem:TopBarItemDirectionRight];

}


#pragma mark -- private methods

- (UIButton *)buttonCreator:(TopBarItemDirection)direction{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [button sizeToFit];
//    button.bounds = CGRectMake(0, 0, 44, 44);
    button.titleLabel.adjustsFontSizeToFitWidth = YES;
    WeakPointer(weakSelf);
    [button setHandleJFEventBlock:^(UIButton *sender) {
        SEL selector = NSSelectorFromString(@"barButtonItemClicked:");
        if ([weakSelf respondsToSelector:selector]) {
            [weakSelf performSelector:selector withObject:[NSNumber numberWithInteger:direction] afterDelay:0];
        }
    }];
    
    return button;
}

- (void)sendActionForBarItem:(TopBarItemDirection )direction {

    UIView *cView = nil;
    if (direction == TopBarItemDirectionRight) {
        cView = self.navigationItem.rightBarButtonItem.customView;
    }else
        cView = self.navigationItem.leftBarButtonItem.customView;
    if (!cView) return ;
    if ([cView isKindOfClass:[UIButton class]]) {
        UIButton *sender = (UIButton *)cView;
        if (!sender.handleJFEventBlock) {
            WeakPointer(weakSelf);
            [sender setHandleJFEventBlock:^(UIButton *sender) {
                
                SEL selector = NSSelectorFromString(@"barButtonItemClicked:");
                if ([weakSelf respondsToSelector:selector]) {
                    [weakSelf performSelector:selector withObject:[NSNumber numberWithInteger:direction] afterDelay:0];
                }

            }];
        }
        [sender eventHandler];
    }
    
}

/*
- (void)sendActionForBarItem:(UIBarButtonItem *)item{
    UIView *cView = item.customView;
    if (!cView) return ;
    if ([cView isKindOfClass:[UIButton class]]) {
        UIButton *sender = (UIButton *)cView;
        if (!sender.handleJFEventBlock) {
            WeakPointer(weakSelf);
            [sender setHandleJFEventBlock:^(UIButton *sender) {
                
                NSString *leftOrRight = nil;
                NSString *value = nil;
                if ([item isEqual:weakSelf.navigationItem.leftBarButtonItem]) {
                    leftOrRight = @"left";
                    value = @"左侧";
                }else{
                    leftOrRight = @"right";
                    value = @"右侧";
                }
                SEL selector = NSSelectorFromString(@"ocToJs_eventAction:");
                if ([weakSelf respondsToSelector:selector]) {
                    NSString *msg = [NSString stringWithFormat:@"您点击了原生按钮:%@",value];
                    [weakSelf performSelector:selector withObject:@{@"key":leftOrRight,@"value":msg} afterDelay:0];
                }
            }];
        }
        [sender eventHandler];
    }
    
}

*/
 
@end
