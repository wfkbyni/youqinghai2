//
//  ZPageView.h
//  nzls
//
//  Created by snailz on 15/12/7.
//  Copyright © 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZPageView;
@protocol ZPageViewDelegate <NSObject>
/**
 *  点击BTN回调代理
 *
 *  @param pageView <#pageView description#>
 *  @param btn      <#btn description#>
 */
-(void)pageView:(ZPageView*)pageView button:(UIButton*)btn;
@end
@interface ZPageView : UIView
@property(nonatomic,strong)NSArray *dataS;//传入btn按钮名字
@property(nonatomic,assign)id<ZPageViewDelegate> delegate;

@property (nonatomic, copy) void(^selectIndexAction)(NSInteger index);
/**
 *  传输index 让该Btn变色
 *
 *  @param index <#index description#>
 */
-(void)selectedIndex:(NSNumber*)index;
@end
