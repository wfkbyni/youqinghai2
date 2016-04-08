//
//  CarTypeTableView.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/31.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "CarTypeTableView.h"

@interface CarTypeTableView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation CarTypeTableView

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor greenColor]];
        self.myTableView = [[UITableView alloc] initWithFrame:CGRectZero];
        self.myTableView.delegate = self;
        self.myTableView.dataSource = self;
        
        [self addSubview:self.myTableView];
    }
    return self;
}

-(void)setCarTypes:(NSArray *)carTypes{
    _carTypes = carTypes;
    self.myTableView.frame = CGRectMake(0, 0, kScreenSize.width, _carTypes.count * 44.0f);
    [self.myTableView setBackgroundColor:[UIColor greenColor]];
        [self setBackgroundColor:[UIColor redColor]];
    [self.myTableView reloadData];
}

-(void)setIsAlpha:(int)isAlpha{
    self.alpha = isAlpha;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _carTypes.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CarType *carType = _carTypes[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = carType.cartypename;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_SelectCarType) {
        self.isAlpha = 0;
        _SelectCarType(_carTypes[indexPath.row]);
    }
}
@end
