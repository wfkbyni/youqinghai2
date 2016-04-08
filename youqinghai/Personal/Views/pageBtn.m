//
//  pageBtn.m
//  nzls
//
//  Created by snailz on 15/12/7.
//  Copyright © 2015年 raychen. All rights reserved.
//

#import "pageBtn.h"

@implementation pageBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.page  = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height-1, frame.size.width, 1)];
        self.page.backgroundColor = [UIColor redColor];
        _page.hidden=YES;
        [self addSubview:_page];
    }
    return self;
}
@end
