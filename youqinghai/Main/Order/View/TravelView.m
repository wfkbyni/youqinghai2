//
//  TravelView.m
//  youqinghai
//
//  Created by 舒永超 on 16/4/6.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "TravelView.h"

@interface TravelView()<UIActionSheetDelegate>

// 出游日期
@property (nonatomic, strong) UILabel *travelDate;
// 出游人数
@property (nonatomic, strong) UILabel *travelCount;
// 出游天数
@property (nonatomic, strong) UILabel *travelDay;
// 拼车类型
@property (nonatomic, strong) UILabel *travelType;

@property (nonatomic, assign) BOOL myHasTrave;
@end

@implementation TravelView

-(instancetype)initWithFrame:(CGRect)frame withIsTrave:(BOOL)isTrave{
    if (self = [super initWithFrame:frame]) {
        
        _myHasTrave = isTrave;
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        if (isTrave) {
            [self commTravel2];
            
        }else{
            [self commTravel1];
        }
    
        
    }
    
    return self;
}

-(void)setCarDetail:(CarDetail *)carDetail{
    _carDetail = carDetail;
    
    if (carDetail.travelTime.length > 0) {
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[carDetail.travelTime longLongValue] / 1000];
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyy-MM-dd hh:mm"];
        NSString *time = [df stringFromDate:date];
        
        [_travelDate setText:[NSString stringWithFormat:@"%@",time]];
    }
    
    [_travelCount setText:[NSString stringWithFormat:@"%ld人",carDetail.seatsnum]];
    NSInteger travelCount = [[[NSUserDefaults standardUserDefaults] objectForKey:YQHViewlist] intValue];
    [_travelDay setText:[NSString stringWithFormat:@"%ld天",[self.calCarPrice.dayNum integerValue]]];
    self.mySeatsnum = carDetail.seatsnum;
    _viewlist = travelCount;
}

// 拼车
- (void)commTravel2{
    CGRect frame = self.frame;
    NSArray *titles = @[@"拼车类型",@"出游日期",@"出游人数",@"出游天数"];
    
    float titleWidth = self.width-30;
    float leftWidth = 110;
    float offset = 0;
    [self addSubview:[self lineWithFrame:CGRectMake(0, offset, CGRectGetWidth(frame), 1)]];
    [self addSubview:[self titleWithFrame:CGRectMake(10, offset + 2, titleWidth, 48) withTitle:titles[0] withTag:TravelTypeWithType]];
    _travelType = [self contentWithFrame:CGRectMake(leftWidth, offset + 2, CGRectGetWidth(self.frame) - leftWidth - 30, 48)];
    [self addSubview:_travelType];
    UIButton *rightArrow = [self rightArrowWithFrame:CGRectMake(CGRectGetWidth(self.frame) - 30, 10, 30, 30)
                                             withTag:TravelTypeWithType];
    [self addSubview:rightArrow];
    
    offset = 50;
    
    [self addSubview:[self lineWithFrame:CGRectMake(10, offset, CGRectGetWidth(frame) - 20, 1)]];
    [self addSubview:[self titleWithFrame:CGRectMake(10, offset + 2, titleWidth, 48) withTitle:titles[1] withTag:TravelTypeWithDate]];
    _travelDate = [self contentWithFrame:CGRectMake(leftWidth, offset + 2, CGRectGetWidth(self.frame) - leftWidth - 30, 48)];
    [self addSubview:_travelDate];
    [self addSubview:[self rightArrowWithFrame:CGRectMake(CGRectGetWidth(self.frame) - 30, 60, 30, 30)
                                       withTag:TravelTypeWithDate]];
    
    offset = 100;
    
    [self addSubview:[self lineWithFrame:CGRectMake(10, offset, CGRectGetWidth(frame) - 20, 1)]];
    [self addSubview:[self titleWithFrame:CGRectMake(10, offset + 2, titleWidth, 48) withTitle:titles[2] withTag:TravelTypeWithCount]];
    _travelCount = [self contentWithFrame:CGRectMake(leftWidth, offset + 2, CGRectGetWidth(self.frame) - leftWidth - 30, 48)];
    [self addSubview:_travelCount];
    [self addSubview:[self rightArrowWithFrame:CGRectMake(CGRectGetWidth(self.frame) - 30, 110, 30, 30)
                                       withTag:TravelTypeWithCount]];
    
    offset = 150;
    
    [self addSubview:[self lineWithFrame:CGRectMake(10, offset, CGRectGetWidth(frame) - 20, 1)]];
    [self addSubview:[self titleWithFrame:CGRectMake(10, offset + 2, titleWidth, 48) withTitle:titles[3] withTag:-1]];
    _travelDay = [self contentWithFrame:CGRectMake(leftWidth, offset + 2, CGRectGetWidth(self.frame) - leftWidth - 30, 48)];
    [self addSubview:_travelDay];
    
    offset = 200;
    [self addSubview:[self lineWithFrame:CGRectMake(0, offset, CGRectGetWidth(frame), 1)]];
}

// 非拼车
- (void)commTravel1{
    CGRect frame = self.frame;
    NSArray *titles = @[@"出游日期",@"出游人数",@"出游天数"];
    float titleWidth = self.width-30;
    float leftWidth = 110;
    float offset = 0;
    [self addSubview:[self lineWithFrame:CGRectMake(0, offset, CGRectGetWidth(frame), 1)]];
    [self addSubview:[self titleWithFrame:CGRectMake(10, offset + 2, titleWidth, 48) withTitle:titles[0] withTag:TravelTypeWithDate]];
    _travelDate = [self contentWithFrame:CGRectMake(leftWidth, offset + 2, CGRectGetWidth(self.frame) - leftWidth - 30, 48)];
    [self addSubview:_travelDate];
    [self addSubview:[self rightArrowWithFrame:CGRectMake(CGRectGetWidth(self.frame) - 30, 10, 30, 30)
                                       withTag:TravelTypeWithDate]];
    
    offset = 50;
    
    [self addSubview:[self lineWithFrame:CGRectMake(10, offset, CGRectGetWidth(frame) - 20, 1)]];
    [self addSubview:[self titleWithFrame:CGRectMake(10, offset + 2, titleWidth, 48) withTitle:titles[1] withTag:TravelTypeWithCount]];
    _travelCount = [self contentWithFrame:CGRectMake(leftWidth, offset + 2, CGRectGetWidth(self.frame) - leftWidth - 30, 48)];
    [self addSubview:_travelCount];
    [self addSubview:[self rightArrowWithFrame:CGRectMake(CGRectGetWidth(self.frame) - 30, 60, 30, 30)
                                       withTag:TravelTypeWithCount]];
    
    offset = 100;
    
    [self addSubview:[self lineWithFrame:CGRectMake(10, offset, CGRectGetWidth(frame) - 20, 1)]];
    [self addSubview:[self titleWithFrame:CGRectMake(10, offset + 2, titleWidth, 48) withTitle:titles[2] withTag:-1]];
    _travelDay = [self contentWithFrame:CGRectMake(leftWidth, offset + 2, CGRectGetWidth(self.frame) - leftWidth - 30, 48)];
    [self addSubview:_travelDay];
    
    offset = 150;
    [self addSubview:[self lineWithFrame:CGRectMake(0, 150, CGRectGetWidth(frame), 1)]];
}


// 分隔线
- (UIView *)lineWithFrame:(CGRect)frame{
    
    UIView *line = [[UIView alloc] initWithFrame:frame];
    [line setBackgroundColor:[UIColor colorWithRed:0.94 green:0.95 blue:0.95 alpha:1.00]];
    
    return line;
}

// 标题
- (UIView *)titleWithFrame:(CGRect)frame withTitle:(NSString *)title withTag:(NSInteger)tag{
    UIControl *control = UIControl.new;
    control.frame = frame;
    UILabel *titleLab = [[UILabel alloc] initWithFrame:control.bounds];
    [titleLab setFont:[UIFont systemFontOfSize:14.0f]];
    [titleLab setText:title];
    titleLab.backgroundColor = [UIColor clearColor];
    titleLab.userInteractionEnabled = NO;
    [control addSubview:titleLab];
    if (tag >= 0) {
        control.tag = tag;
        [control addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }

    
    return control;
}

// 内容
- (UILabel *)contentWithFrame:(CGRect)frame{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    [label setFont:[UIFont systemFontOfSize:14.0f]];
    [label setTextAlignment:NSTextAlignmentRight];
    return label;
}

// 箭头
- (UIButton *)rightArrowWithFrame:(CGRect)frame withTag:(NSInteger)tag{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setTag:tag];
    [button setImage:[UIImage imageNamed:@"arrow_right"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)btnAction:(UIButton *)sender{
    NSLog(@"%zi",sender.tag);
    switch (sender.tag) {
        case TravelTypeWithType:
        {
            [self selectCarType];
        }
            break;
        case TravelTypeWithDate:
        {
            if (!_myHasTrave) {
                return;
            }
            [self selectDate];
        }
            break;
        case TravelTypeWithCount:
        {
            [self selectPersonCount:self.mySeatsnum];
        }
            break;
            
        default:
            break;
    }
}

- (void)selectCarType{
    if (([UIDevice currentDevice].systemVersion.floatValue > 8.0)) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择拼车类型" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        for (int i = 0; i < _calcPrice.listType.count; i++) {
            CarType *carType = _calcPrice.listType[i];
            UIAlertAction *action = [UIAlertAction actionWithTitle:carType.cartypename style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self.travelType.text = carType.cartypename;
                NSLog(@"%ld",carType.Id);
                self.carDetail.cartypeId = carType.Id;
                self.mySeatsnum = carType.seatsnum;
                if (_TravelSelectBlock) {
                    [_travelCount setText:[NSString stringWithFormat:@"%@人",@(carType.seatsnum)]];
                    _TravelSelectBlock(TravelTypeWithType,carType);
                }
            }];
            
            [alertController addAction:action];
        }
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:cancelAction];
        
        [self.navigationController.visibleViewController presentViewController:alertController animated:YES completion:nil];
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请选择拼车类型" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }
}

/**
 *  @brief 选择出游日期
 */
- (void)selectDate{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIDatePicker *picker = [[UIDatePicker alloc] init];
    picker.minuteInterval = 30;
    picker.minimumDate = [NSDate date];
    [picker setDatePickerMode:UIDatePickerModeDateAndTime];
    [alertController.view addSubview:picker];
    [alertController addAction:({
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSDateFormatter *form = [[NSDateFormatter alloc] init]; // 定义时间格式
            [form setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSString *dateString = [form stringFromDate:picker.date];
            
            self.travelDate.text = dateString;
            
            if (_TravelSelectBlock) {
                _TravelSelectBlock(TravelTypeWithDate,picker.date);
            }

        }];
        action;
    })];
    UIPopoverPresentationController *popoverController = alertController.popoverPresentationController;
    popoverController.sourceView = self.navigationController.visibleViewController.view;
    popoverController.sourceRect = [self.navigationController.visibleViewController.view bounds];
    [self.navigationController.visibleViewController presentViewController:alertController  animated:YES completion:nil];
}

- (void)selectPersonCount:(NSInteger)travelnum{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"请选择出行人数" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    for(NSInteger i = 1; i <= travelnum; i ++){
        
        [controller addAction:[UIAlertAction actionWithTitle:[NSString stringWithFormat:@"%ld",i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [_travelCount setText:[NSString stringWithFormat:@"%@人",action.title]];
            //self.mySeatsnum = [action.title intValue];
            if (_TravelSelectBlock) {
                _TravelSelectBlock(TravelTypeWithCount,action.title);
            }
        }]];
    }
    
    [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [_navigationController presentViewController:controller animated:YES completion:NULL];
}

-(void)setCalCarPrice:(CalCarPrice *)calCarPrice{
    _calCarPrice = calCarPrice;
    [_travelDay setText:[NSString stringWithFormat:@"%ld天",[self.calCarPrice.dayNum integerValue]]];
 
}
-(void)setCalcPrice:(CalcPrice *)calcPrice{
    _calcPrice = calcPrice;
    [_travelDay setText:[NSString stringWithFormat:@"%ld天",[self.calcPrice.day integerValue]]];
    
}


@end
