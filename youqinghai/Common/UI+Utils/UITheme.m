//
//  NSObject+UITheme.m
//  FCHealthy
//
//  Created by mouxiaochun on 16/2/1.
//  Copyright © 2016年 mmc. All rights reserved.
//

#import "UITheme.h"
#define ColorWithRGB(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]
#define ColorWithOne(R) [UIColor colorWithRed:R/255.0 green:R/255.0 blue:R/255.0 alpha:1.0]
#define FontWithSize(size) [UIFont systemFontOfSize:size]

@implementation UITheme


#pragma mark -- 主题颜色

UIColor*  navigatorColor() {

    return ColorWithRGB(39,172,241);
}
UIColor *grayTextColor() {
    return ColorWithRGB(180, 180, 180);
    
}
UIColor * spaceColor238238238()
{
    return ColorWithOne(238);
}

#pragma mark --- Font

UIFont * fontSystem11(){
    return  FontWithSize(11);
}
UIFont * fontSystem12(){
    return  FontWithSize(12);

}
UIFont * fontSystem13(){
    return  FontWithSize(13);

}
UIFont * fontSystem14(){
    return  FontWithSize(14);

}
UIFont * fontSystem15(){
    return  FontWithSize(15);

}
UIFont * fontSystem16(){
    return  FontWithSize(16);

}





#pragma mark --- View相关

//向右的箭头
+ (UIImageView *)accessoryView {

    UIImage *image = [UIImage imageNamed:@"go_gray"];
    UIImageView *iv = [[UIImageView alloc] initWithImage:image];
    iv.frame = (CGRect){0,0,image.size};
    return iv;
}

//橘红色按钮
+ (UIButton *)orangeButton {
    return [UITheme btCreator: @"btn_link_active"];
}
//登录按钮
+ (UIButton *)loginButton {
    return [UITheme btCreator: @"login_btn"];

}

//上传身份证按钮
+ (UIButton *)uploadButton {
    return [UITheme btCreator: @"register_btn"];
    
}

//注册按钮
+ (UIButton *)registerButton {
    return [UITheme btCreator: @"btn_link1"];
}


+ (UIButton *)btCreator:(NSString *)btImageName
{
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:btImageName];
    image = [image stretchableImageWithLeftCapWidth:4 topCapHeight:3];
    [bt setBackgroundImage:image forState:UIControlStateNormal];
    bt.frame = (CGRect){12,0,Screen.width - 24,40};
    [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    bt.titleLabel.font = [UIFont systemFontOfSize:16];
    return bt;
}


@end





@implementation NSString (att)

- (NSMutableAttributedString *) changeText:(NSString *)string forColor:(UIColor *)color 
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self];
    NSRange range = [self rangeOfString:string];
    [str addAttribute:NSForegroundColorAttributeName value:color range:range];
    return str;
}

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    CGSize size =  [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    return CGSizeMake(size.width+6,size.height);
}

@end