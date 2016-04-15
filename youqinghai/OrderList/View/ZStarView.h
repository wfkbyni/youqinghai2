//
//  ZStarView.h
//  timeText
//
//  Created by HY007 on 15/8/20.
//  Copyright (c) 2015年 HY007. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZStarView;
@protocol  ZStarViewDelagete <NSObject>

-(void)ZStarView:(ZStarView*)starView clickButton:(UIButton*)button;

@end
@interface ZStarView : UIView
@property(nonatomic,assign)CGFloat starCount;
@property(nonatomic,assign)id<ZStarViewDelagete> delegate;
 
@end
