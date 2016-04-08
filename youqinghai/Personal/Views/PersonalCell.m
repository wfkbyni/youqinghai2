//
//  PersonalCell.m
//  QingHaiTourClient
//
//  Created by mouxiaochun on 16/3/13.
//  Copyright © 2016年 mmc. All rights reserved.
//

#import "PersonalCell.h"
#import "ZLoginViewController.h"
@implementation PersonalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImage *image = [UIImage imageNamed:@"我的_个人资料_账户安全_03"];
        UIImageView *iv = [[UIImageView alloc] initWithImage:image];
        self.accessoryView = iv;
    }
    return self;
}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    self.imageView.frame = (CGRect){10,(self.height - self.imageView.height)/2,self.imageView.size};
    CGRect frame = self.textLabel.frame;
    frame.origin.x = self.imageView.relativeX+10;
    self.textLabel.frame = frame;
}
@end
