//
//  TravelCell.m
//  QingHaiTourClient
//
//  Created by mouxiaochun on 16/3/13.
//  Copyright © 2016年 mmc. All rights reserved.
//

#import "TravelCell.h"

@interface TravelCell ()

{

    UIImageView *_snapshot; //图片
    UILabel *_desc; //文字描述

    UIButton *_likeBT;//赞
    UIButton *_scanBT;//浏览
    UIButton *_chatBT; //聊天
    UIButton *_heartBT; //喜欢
    UIButton *_shareBT;//分享按钮
    
    UIView *_bottomSubview;
    
    CALayer *_seperator;//分割线
    CALayer *_seperator01;//竖分割线1
    CALayer *_seperator02;//竖分割线2

}

@end

@implementation TravelCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.imageView.image = [UIImage imageNamed:@"01.jpg"];
        self.imageView.layer.masksToBounds = YES;
        
        self.textLabel.text = @"李大玲";
        self.detailTextLabel.text = @"2015-12-12 11:43";
        self.textLabel.font = fontSystem14();
        self.detailTextLabel.font = fontSystem12();
        self.detailTextLabel.textColor = grayTextColor();
        
        
        
        _snapshot = UIImageView.new;
        _snapshot.image = [UIImage imageNamed:@"02"];
        _snapshot.layer.cornerRadius = 5;
        _snapshot.layer.masksToBounds = YES;
        [self.contentView addSubview:_snapshot];
        
        _desc = UILabel.new;
        NSString *title = @"两会时间过半，从民建、工商联委员联组会，到上海、黑龙江等代表团，习近平已经到过五个团组。从三个“没有变”到“保护作风正派、锐意进取的干部”再到“坚决守住民生底线，坚决打赢脱贫攻坚战”……七天五次讲话，习近平为这五种人“撑腰”。";
        
        _desc.text = title;
        _desc.lineBreakMode = NSLineBreakByCharWrapping;
        _desc.numberOfLines = 20;
        _desc.font = fontSystem13();
        [self.contentView addSubview:_desc];
        
        
        _scanBT = [self createBT:nil title:@"59"];
        self.accessoryView = _scanBT;
        
        _seperator = self.seperatorline;
        [self.contentView.layer addSublayer:_seperator];
        
        
        _bottomSubview = UIView.new;
        [self.contentView addSubview:_bottomSubview];
        
        _likeBT = [self createBT:nil title:@"23"];
        _chatBT = [self createBT:nil title:nil];
        _heartBT = [self createBT:nil title:nil];
        _shareBT = [self createBT:nil title:nil];
        
        [_bottomSubview addSubview:_likeBT];
        [_bottomSubview addSubview:_chatBT];
        [_bottomSubview addSubview:_heartBT];
        [_bottomSubview addSubview:_shareBT];
        
        _seperator01 = self.seperatorline;
        [_bottomSubview.layer addSublayer:_seperator01];
        _seperator02 = self.seperatorline;
        [_bottomSubview.layer addSublayer:_seperator02];

        
        
    }
    return self;

}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    self.imageView.frame = (CGRect){10,10,32,32};
    self.imageView.layer.cornerRadius = self.imageView.width/2;
    
    CGRect frame = self.textLabel.frame;
    frame.origin.x = self.imageView.relativeX+5;
    frame.origin.y = self.imageView.y;
    self.textLabel.frame = frame;
    
    frame = self.detailTextLabel.frame;
    frame.origin.x = self.textLabel.x;
    frame.origin.y = self.textLabel.relativeY;
    self.detailTextLabel.frame = frame;
    
    frame = self.accessoryView.frame;
    frame.origin.x = self.width - frame.size.width-10;
    frame.origin.y = self.textLabel.y;
    self.accessoryView.frame = frame;
    
    _snapshot.frame = (CGRect){self.imageView.x,self.imageView.relativeY+10,self.width-20,210};
    NSString *text = _desc.text ;
    CGSize size = [text sizeWithFont:_desc.font maxSize:CGSizeMake(_desc.width, 100)];
    _desc.frame = (CGRect){_snapshot.x,_snapshot.relativeY+10,_snapshot.width,size.height};
    
    _seperator.frame = (CGRect){_snapshot.x,_desc.relativeY+10,_desc.width,0.5};
    
    _bottomSubview.frame = (CGRect){0,_seperator.frame.origin.y+1,self.width,44};
    
    _likeBT.frame = (CGRect){_desc.x,10,_likeBT.width,_likeBT.height};
    
    _shareBT.frame = (CGRect){_bottomSubview.width-10-_shareBT.width,_likeBT.y,_shareBT.width,_shareBT.height};
    _seperator02.frame = (CGRect){_shareBT.x-15,10,0.5,_bottomSubview.height-20};
    _heartBT.frame = (CGRect){_seperator02.frame.origin.x-15-_heartBT.width,_likeBT.y,_heartBT.width,_heartBT.height};
    _seperator01.frame = (CGRect){_heartBT.x-15,10,0.5,_bottomSubview.height-20};
    _chatBT.frame = (CGRect){_seperator01.frame.origin.x-15-_chatBT.width,_likeBT.y,_chatBT.width,_chatBT.height};


    
    
}

- (UIButton *)createBT:(NSString *)imageName title:(NSString *)title {
    imageName = @"star_yellow";
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:imageName];
    [bt setImage:image  forState:UIControlStateNormal];
    [bt setTitle:title forState:UIControlStateNormal];
    [bt setTitleColor:grayTextColor() forState:UIControlStateNormal];

    [bt sizeToFit];
    return bt;
}

@end
