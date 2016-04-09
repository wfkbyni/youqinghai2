//
//  OrderListDetailCell.m
//  youqinghai
//
//  Created by mouxiaochun on 16/4/8.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "OrderListDetailCell.h"

@implementation OrderListDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.textLabel.font = [UIFont systemFontOfSize:15];
        self.detailTextLabel.font = [UIFont systemFontOfSize:15];
        self.detailTextLabel.textColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0];
    }
    return self;
}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    CGRect frame = self.textLabel.frame;
    frame.origin.x = 10;
    frame.origin.y = (self.height - frame.size.height)/2;
    self.textLabel.frame = frame;
    
    frame = self.detailTextLabel.frame;
    frame.origin.y = self.textLabel.y;
    frame.origin.x = 100;
    self.detailTextLabel.frame = frame;
}

@end
