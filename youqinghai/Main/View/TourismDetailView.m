//
//  TourismDetailView.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/27.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "TourismDetailView.h"

#define line 20
#define rowHeight 120
#define leftViewWidth 80
#define rightViewWidth kScreenSize.width - leftViewWidth

@implementation TourismDetailView

-(void)setViewlist:(NSArray *)viewlist{
    _viewlist = viewlist;
    
    float height = [self calculateHeight];
    
    [self setFrame:CGRectMake(0, 0, kScreenSize.width, height)];
    
    if (viewlist.count > 0) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.frame];
        [self addSubview:imageView];
        [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://hiphotos.baidu.com/lvpics/pic/item/a1ad16fa4f2fd8fe59ee90d9.jpg"]];
        
        UIView *bgView = [[UIView alloc] initWithFrame:self.frame];
        [bgView setBackgroundColor:[UIColor blackColor]];
        [bgView setAlpha:0.5];
        [self addSubview:bgView];
    }
    
    __block float y = line;
    [_viewlist enumerateObjectsUsingBlock:^(Traveltrip *traveltrip, NSUInteger idx, BOOL * _Nonnull stop) {
        
        float __rowHeight = [self tourismRowHeight:traveltrip];
        
        LeftViewModel model;
        if (idx == 0) {
            model = LeftViewModelTop;
        }else if(idx == _viewlist.count - 1){
            model = LeftViewModelBottom;
        }else{
            model = LeftViewModelCenter;
        }
        
        // 添加左边的view
        [self addSubview:[self leftViewWithType:model withOriginY:y withHeight:__rowHeight withTraveltrip:traveltrip]];
        
        // 添加右边的view
        [self addSubview:[self rightViewWithTraveltrip:traveltrip withOriginY:y withHeight:__rowHeight]];
        
        y += __rowHeight;
        
    }];
}

/**
 *  @brief 左边view
 *
 *  @param model      <#model description#>
 *  @param y          <#y description#>
 *  @param heihgt     <#heihgt description#>
 *  @param traveltrip <#traveltrip description#>
 *
 *  @return <#return value description#>
 */
- (UIView *)leftViewWithType:(LeftViewModel)model withOriginY:(float)y withHeight:(float)heihgt withTraveltrip:(Traveltrip *)traveltrip{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, y, leftViewWidth, heihgt)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((60 - 24) / 2, 0, 24, 24)];
    [imageView setBackgroundColor:[UIColor redColor]];
    [view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 28, 60, 21)];
    [label setText:[NSString stringWithFormat:@"Day:%ld",traveltrip.day]];
    [label setFont:[UIFont systemFontOfSize:14.0f]];
    [label setTextColor:[UIColor whiteColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [view addSubview:label];
    
    UIView *radiusView = [[UIView alloc] initWithFrame:CGRectMake(leftViewWidth - 20, 10, 10, 10)];
    [radiusView setBackgroundColor:[UIColor whiteColor]];
    [radiusView viewWithCornerRadius:5];
    [view addSubview:radiusView];
    
    float offset = 0;
    switch (model) {
        case LeftViewModelTop: {
            offset = 10;
            break;
        }
        case LeftViewModelCenter: {
            offset = 0;
            break;
        }
        case LeftViewModelBottom: {
            radiusView = [[UIView alloc] initWithFrame:CGRectMake(leftViewWidth - 20, heihgt - 30, 10, 10)];
            [radiusView setBackgroundColor:[UIColor whiteColor]];
            [radiusView viewWithCornerRadius:5];
            [view addSubview:radiusView];
            break;
        }
    }
    
    UIView *vLine = [[UIView alloc] initWithFrame:CGRectMake(leftViewWidth - 16, offset, 2, model == LeftViewModelBottom ? heihgt - 21 : heihgt)];
    [vLine setBackgroundColor:[UIColor whiteColor]];
    [view addSubview:vLine];
    
    if (model == LeftViewModelBottom) {
        UILabel *endLab = [[UILabel alloc] initWithFrame:CGRectMake(leftViewWidth - 25, CGRectGetMaxY(vLine.frame), 40, 20)];
        [endLab setFont:[UIFont systemFontOfSize:12.0f]];
        [endLab setTextColor:[UIColor whiteColor]];
        [endLab setText:@"End"];
        [view addSubview:endLab];
    }
    
    return view;
}

- (UIView *)rightViewWithTraveltrip:(Traveltrip *)traveltrip withOriginY:(float)y withHeight:(float)heihgt{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(leftViewWidth, y + 2, rightViewWidth, heihgt)];
    
    NSArray *viewlist = traveltrip.viewlist;
    
    float hLine = 10;
    float width = (rightViewWidth - 4 * hLine) / 3;
    [viewlist enumerateObjectsUsingBlock:^(Trip *trip, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger row = (viewlist.count % 3 == 0 ? (viewlist.count / 3) : (viewlist.count / 3 + 1)) - 1;
        UIImageView *itemView = [[UIImageView alloc] initWithFrame:CGRectMake(idx * hLine + idx * width + hLine, row * hLine + row * width, width, width)];
        [itemView sd_setImageWithURL:[NSURL URLWithString:trip.tripimgurl]];
        [itemView viewWithCornerRadius:5];
        [itemView viewWithBorderWidth:2 WithBorderColor:[UIColor whiteColor]];
        [view addSubview:itemView];
        
        CGRect frame = itemView.frame;
        frame.origin.y = CGRectGetMaxY(itemView.frame) + 2;
        frame.size.height = 21;
        UILabel *itemName = [[UILabel alloc] initWithFrame:frame];
        itemName.textAlignment = NSTextAlignmentCenter;
        itemName.font = [UIFont systemFontOfSize:13.0f];
        [itemName setText:trip.tripname];
        [itemName setTextColor:[UIColor whiteColor]];
        [view addSubview:itemName];
    }];
    
    return view;
}

/**
 *  @brief 计算总高度
 *
 *  @return scrollView height
 */
- (float)calculateHeight{
    
    float totoaHeight = line * 2;
    
    for (NSInteger i = 0; i < _viewlist.count; i++) {
        
        Traveltrip *traveltrip = (Traveltrip *)_viewlist[i];
        
        totoaHeight += [self tourismRowHeight:traveltrip];
    }
    
    return totoaHeight;
}

/**
 *  @brief 一行的高度
 *
 *  @param traveltrip <#traveltrip description#>
 *
 *  @return <#return value description#>
 */
- (float)tourismRowHeight:(Traveltrip *)traveltrip{
    float height = 0;
    
    if (traveltrip.viewlist.count <= 3) {
        height = rowHeight;
    }else{
        NSInteger row = traveltrip.viewlist.count % 3 == 0 ? (traveltrip.viewlist.count / 3) : (traveltrip.viewlist.count / 3 + 1);
        
        height = row * rowHeight;
    }
    
    return height;

}

@end
