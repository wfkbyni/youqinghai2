//
//  DriverCarIntroduceTableViewCell.m
//  youqinghai
//
//  Created by 舒永超 on 16/4/4.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "DriverCarIntroduceTableViewCell.h"
#import "DriverCarCellHeaderView.h"

@interface DriverCarIntroduceTableViewCell()

@property (nonatomic, strong) DriverCarCellHeaderView *headerView;

@property (nonatomic, strong) UILabel *introduceView;
@end

@implementation DriverCarIntroduceTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addSubview:self.headerView];
        
        [self addSubview:self.introduceView];
        
    }
    return self;
}

- (void)setDriverInfo:(NSString *)driverInfo{
    self.introduceView.text = driverInfo;
    
    float height = [driverInfo calHeightWithWidth:kScreenSize.width - 20 withFontSize:14];
    CGRect frame = self.introduceView.frame;
    frame.size.height = height;
    self.introduceView.frame = frame;
}

- (DriverCarCellHeaderView *)headerView{
    
    if (!_headerView) {
        _headerView = [[DriverCarCellHeaderView alloc] initWithFrame:CGRectZero withImageName:@"collection_off" withTitle:@"个人介绍"];
    }
    
    return _headerView;
}

- (UILabel *)introduceView{
    
    if (!_introduceView) {
        _introduceView = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, kScreenSize.width - 20, 100)];
        [_introduceView setFont:[UIFont systemFontOfSize:14]];
        [_introduceView setNumberOfLines:0];
    }
    
    return  _introduceView;
}

@end
