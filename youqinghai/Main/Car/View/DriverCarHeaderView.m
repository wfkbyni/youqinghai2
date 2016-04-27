//
//  DriverCarHeaderView.m
//  youqinghai
//
//  Created by 舒永超 on 16/4/4.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "DriverCarHeaderView.h"

@interface DriverCarHeaderView()

// view的高度
@property (nonatomic, assign) float viewHeight;
// 司机名
@property (nonatomic, strong) UILabel *carName;
// 车型
@property (nonatomic, strong) UILabel *carTypeLabel;
// 车座
@property (nonatomic, strong) UILabel *carSeatsNum;
// 服务次数
@property (nonatomic, strong) UILabel *serviceCountLab;
// 驾龄
@property (nonatomic, strong) UILabel *drivingYearLabel;
// 收藏
@property (nonatomic, strong) UILabel *collectionCountLab;
// 性别
@property (nonatomic, strong) UIImageView *sexImageView;
// 头像
@property (nonatomic, strong) UIImageView *headImageView;


@end

@implementation DriverCarHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self.viewHeight = CGRectGetHeight(frame);
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:[self introduceView]];
        
        @weakify(self)
        [RACObserve(self, viewHeight) subscribeNext:^(id x) {
            @strongify(self)
            
            CGRect frame = self.frame;
            frame.size.height = [x floatValue];
            
            self.frame = frame;
        }];
        
    }
    return self;
}

// 司机介绍view
- (UIView *)introduceView{
    
    /**-------------------------------------------------------------------------**/
    
    UIView *view = [[UIView alloc] initWithFrame:self.frame];
    
    CGRect frame = view.frame;
    frame.size.height = CGRectGetHeight(frame) - 100;
    
    _bgImageView = [[UIImageView alloc] initWithFrame:frame];
    [_bgImageView setImage:[_bgImageView clipImage:[UIImage imageNamed:@"detail_header_bg"] toSize:view.frame.size]];
    
    [view addSubview:_bgImageView];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setFrame:CGRectMake(10, 20, 40, 40)];
    [backBtn setTag:BtnClickEventWithBack];
    [backBtn setImage:[UIImage imageNamed:@"arrow_left"] forState:UIControlStateNormal];
    
    [view addSubview:backBtn];
    
    _collectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _collectionBtn.frame = CGRectMake(CGRectGetWidth(self.frame) - 40 - 10, 20, 40, 40);
    [_collectionBtn setTag:BtnClickEventWithCollection];
    [_collectionBtn setImage:[UIImage imageNamed:@"collection"] forState:UIControlStateNormal];
    [view addSubview:_collectionBtn];
    
    [backBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_collectionBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _carName = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, CGRectGetWidth(self.frame) / 2, 20)];
    [_carName setFont:[UIFont systemFontOfSize:18.0f]];
    [_carName setTextColor:[UIColor whiteColor]];
    [_carName setText:@"陆离"];
    [_carName setTextAlignment:NSTextAlignmentRight];
    
    [view addSubview:_carName];
    
    _sexImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) / 2, 40, 20, 20)];
    
    [view addSubview:_sexImageView];
    
    /**-------------------------------------------------------------------------**/
    
    _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.frame) - 48) / 2, CGRectGetMaxY(_sexImageView.frame) + 15, 48, 48)];
    
    [_headImageView viewWithCornerRadius:CGRectGetWidth(_headImageView.frame) / 2];
    
    [view addSubview:_headImageView];
    
    _carTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_headImageView.frame) + 5, CGRectGetWidth(self.frame), 21)];
    [_carTypeLabel setTextAlignment:NSTextAlignmentCenter];
    [_carTypeLabel setText:@"经济型"];
    [_carTypeLabel setTextColor:[UIColor whiteColor]];
    
    [view addSubview:_carTypeLabel];

    
    _carSeatsNum = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_carTypeLabel.frame) + 5, CGRectGetWidth(self.frame), 21)];
    [_carSeatsNum setTextAlignment:NSTextAlignmentCenter];
    [_carSeatsNum setText:@"哈弗H6 5座"];
    [_carSeatsNum setTextColor:[UIColor whiteColor]];
    
    [view addSubview:_carSeatsNum];
    
    /**-------------------------------------------------------------------------**/

    float width = 120;
    
    UILabel *serviceLab = [[UILabel alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.frame) - width) / 2, CGRectGetMaxY(_carSeatsNum.frame) + 20, width, 20)];
    [serviceLab setTextColor:[UIColor whiteColor]];
    [serviceLab setText:@"服务"];
    [serviceLab setTextAlignment:NSTextAlignmentCenter];
    
    [view addSubview:serviceLab];
    
    _serviceCountLab = [[UILabel alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.frame) - width) / 2, CGRectGetMaxY(serviceLab.frame) + 5, width, 20)];
    [_serviceCountLab setTextColor:[UIColor whiteColor]];
    [_serviceCountLab setText:@"23次"];
    [_serviceCountLab setTextAlignment:NSTextAlignmentCenter];
    
    [view addSubview:_serviceCountLab];
    
    UILabel *drivingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_carSeatsNum.frame) + 20, (CGRectGetWidth(self.frame) - width) / 2, 20)];
    [drivingLabel setTextAlignment:NSTextAlignmentRight];
    [drivingLabel setTextColor:[UIColor whiteColor]];
    [drivingLabel setText:@"驾龄"];
    
    [view addSubview:drivingLabel];
    
    _drivingYearLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(drivingLabel.frame) + 5, (CGRectGetWidth(self.frame) - width) / 2, 20)];
    [_drivingYearLabel setTextAlignment:NSTextAlignmentRight];
    [_drivingYearLabel setTextColor:[UIColor whiteColor]];
    [_drivingYearLabel setText:@"8年"];
    
    [view addSubview:_drivingYearLabel];
    
    UILabel *collectionLab = [[UILabel alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.frame) - width) / 2 + width, CGRectGetMaxY(_carSeatsNum.frame) + 20, (CGRectGetWidth(self.frame) - width) / 2, 20)];
    [collectionLab setTextAlignment:NSTextAlignmentLeft];
    [collectionLab setTextColor:[UIColor whiteColor]];
    [collectionLab setText:@"评价"];
    
    [view addSubview:collectionLab];
    
    _collectionCountLab = [[UILabel alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.frame) - width) / 2 + width, CGRectGetMaxY(collectionLab.frame) + 5, (CGRectGetWidth(self.frame) - width) / 2, 20)];
    [_collectionCountLab setTextAlignment:NSTextAlignmentLeft];
    [_collectionCountLab setTextColor:[UIColor whiteColor]];
    [_collectionCountLab setText:@"10次"];
    
    [view addSubview:_collectionCountLab];
    
    UIView *line1 = [[UILabel alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.frame) - width) / 2 + 20, CGRectGetMaxY(_carSeatsNum.frame) + 30, 0.5, 30)];
    [line1 setBackgroundColor:[UIColor whiteColor]];
    
    [view addSubview:line1];
    
    UIView *line2 = [[UILabel alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.frame) - width) / 2 + width - 20, CGRectGetMaxY(_carSeatsNum.frame) + 30, 0.5, 30)];
    [line2 setBackgroundColor:[UIColor whiteColor]];
    
    [view addSubview:line2];
    /**-------------------------------------------------------------------------**/
    float itemWidht = kScreenSize.width / 3;
    NSArray *titles = @[@"车载Wifi",@"急救包",@"氧气袋",@"雨伞",@"摄影协助"];
    for (NSInteger i = 0; i < titles.count; i++) {
        
        NSInteger row = i / 3;
        NSInteger column = i % 3;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(column * itemWidht + 10, row * 50 + self.viewHeight - 100, itemWidht, 50)];
        [button setEnabled:NO];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"detail_0%ld",i + 1]] forState:UIControlStateNormal];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:0.33 green:0.34 blue:0.34 alpha:1.00] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        
        [self addSubview:button];
    }
    
    /**-------------------------------------------------------------------------**/
    
    return view;
}

- (void)bindData:(CarDetail *)carDetail{
    _sexImageView.image = carDetail.sex == 0 ? [UIImage imageNamed:@"woman"] : [UIImage imageNamed:@"man"];
    
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:carDetail.headUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        _headImageView.image = [_headImageView clipImage:image toSize:_headImageView.frame.size];
        [_headImageView viewWithBorderWidth:2 WithBorderColor:[UIColor grayColor]];
    }];
    _carName.text = carDetail.nickname;
    _carTypeLabel.text = carDetail.cartypename;
    _carSeatsNum.text = [NSString stringWithFormat:@"%@ %ld座",carDetail.carname, carDetail.seatsnum];
    _serviceCountLab.text = [NSString stringWithFormat:@"%ld 次",carDetail.sernum];
    _drivingYearLabel.text = [NSString stringWithFormat:@"%ld 年",carDetail.driveage];
    _collectionCountLab.text = [NSString stringWithFormat:@"%ld %%", carDetail.eav];
}

- (void)btnAction:(UIButton *)sender{
    
    if (_BtnClickEvent) {
        _BtnClickEvent(sender.tag);
    }
}

- (void)chagneHeight{
    self.viewHeight = 300;
}

@end
