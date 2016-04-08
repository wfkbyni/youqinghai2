//
//  OrderListCell.m
//  youqinghai
//
//  Created by mouxiaochun on 16/4/8.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "OrderListCell.h"

@interface OrderListCell ()

{
    UIView      *_subView;
    UIImageView *_picIV;
    UILabel     *_titleLB; //标题，如青海一日游
    UILabel     *_tourDateLB; //出游日期
    UILabel     *_tourNumLB; //出游人数
    UILabel     *_carTypeLB; //车辆类型
    UILabel     *_moneyLB;  //定金
    
    
    UIView      *_bottomSubView;
    UILabel     *_tourTypeLB;//包车、拼车 出游类型
    
}

@end

@implementation OrderListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self commonInit];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

- (void)commonInit {

    _subView = UIView.new;
    _subView.backgroundColor = [UIColor colorWithRed:248.0/255.0 green:248.0/255.0 blue:248.0/255.0 alpha:1.0];
    [self.contentView addSubview:_subView];
    
    _picIV = UIImageView.new;
    _picIV.image = [UIImage imageNamed:@"02"];
    [_subView addSubview:_picIV];
    
    _titleLB = UILabel.new;
    _titleLB.font = [UIFont systemFontOfSize:15];
    _titleLB.text = @"青海三日游";
    [_subView addSubview:_titleLB];
    
    _tourDateLB = UILabel.new;
    _tourDateLB.text = @"出游日期:2016-01-01";
    _tourDateLB.font = [UIFont systemFontOfSize:12];
    _tourDateLB.textColor = [UIColor colorWithRed:180.0/255.0 green:180.0/255.0 blue:180.0/255.0 alpha:1.0];
    [_subView addSubview:_tourDateLB];
    
    
    _tourNumLB = UILabel.new;
    _tourNumLB.text = @"出游人数: 3人";
    _tourNumLB.font = [UIFont systemFontOfSize:12];
    _tourNumLB.textColor = [UIColor colorWithRed:180.0/255.0 green:180.0/255.0 blue:180.0/255.0 alpha:1.0];
    _tourNumLB.textAlignment =NSTextAlignmentRight;
    [_tourNumLB sizeToFit];
    [_subView addSubview:_tourNumLB];
    
    
    _carTypeLB = UILabel.new;
    _carTypeLB.text = @"车辆类型: 经济型";
    _carTypeLB.font = [UIFont systemFontOfSize:12];
    _carTypeLB.textColor = [UIColor colorWithRed:180.0/255.0 green:180.0/255.0 blue:180.0/255.0 alpha:1.0];
    [_subView addSubview:_carTypeLB];
    
    
    _moneyLB = UILabel.new;
    _moneyLB.text = @"定金: ￥83";
    _moneyLB.font = [UIFont systemFontOfSize:12];
    _moneyLB.textColor = [UIColor colorWithRed:180.0/255.0 green:180.0/255.0 blue:180.0/255.0 alpha:1.0];
    _moneyLB.textAlignment = NSTextAlignmentRight;
    [_moneyLB sizeToFit];
    [_subView addSubview:_moneyLB];
    
    
    _bottomSubView = UIView.new;
    [self.contentView addSubview:_bottomSubView];
    
    _tourTypeLB = UILabel.new;
    _tourTypeLB.font = [UIFont systemFontOfSize:16];
    _tourTypeLB.text = @"包车出游";
    [_bottomSubView addSubview:_tourTypeLB];
    
    self.contentView.backgroundColor = [UIColor  whiteColor];
    self.textLabel.text = @"2015-01-01 11:50:30";
    self.textLabel.textColor = [UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:1.0];
    self.textLabel.font = [UIFont systemFontOfSize:13];
    
    self.detailTextLabel.text = @"2015-01-01 11:50:30";
    self.detailTextLabel.textColor = [UIColor redColor];
    self.detailTextLabel.font = [UIFont systemFontOfSize:13];
    
}


- (void)layoutSubviews {

    [super layoutSubviews];
    CGFloat leftEdge = 10.0;
    
    CGRect frame   = self.textLabel.frame;
    frame.origin.x = leftEdge;
    frame.origin.y = 10.0f;
    self.textLabel.frame = frame;
    
    frame = self.detailTextLabel.frame;
    frame.origin.x = self.frame.size.width - frame.size.width - leftEdge;
    frame.origin.y = self.textLabel.frame.origin.y;
    self.detailTextLabel.frame = frame;
    
    _subView.frame = (CGRect){0,self.textLabel.relativeY+5,self.width  ,134};
    
    _picIV.frame = (CGRect){leftEdge,10.0f,150,112};
    CGFloat x    = _picIV.relativeX+5;
    _titleLB.frame    = (CGRect){x,_picIV.y,self.width - x,20};
    
    
    
    
    
    _tourDateLB.frame = (CGRect){_titleLB.x,_titleLB.relativeY+15,120,20};

    _carTypeLB.frame  = (CGRect){_titleLB.x,_picIV.height-25,_tourDateLB.size};


    _tourNumLB.frame  = (CGRect){self.width-_tourNumLB.width-5,_tourDateLB.y,_tourNumLB.width,_tourDateLB.height};
    _moneyLB.frame    = (CGRect){self.width-_moneyLB.width-5,_carTypeLB.y,_moneyLB.width,_tourDateLB.height};

    
    _bottomSubView.frame = (CGRect){0,_subView.relativeY,self.width,53};
    _tourTypeLB.frame    = (CGRect){leftEdge,0,80,_bottomSubView.height};
    
}

@end
