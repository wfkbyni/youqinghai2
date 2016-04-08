//
//  TourisEvaluateView.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/28.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "TourisEvaluateView.h"
#import "TourisEvaluateCell.h"

@interface TourisEvaluateView()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *myTableView;

@property (nonatomic, strong) NSArray *tourisEvaluates;

@property (nonatomic, strong) NSMutableDictionary *cacheRowHeight;

@end

#define cellIdeitifier @"TourisEvaluateCell"

@implementation TourisEvaluateView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        _myTableView = [[UITableView alloc] initWithFrame:frame];
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
        
        [self addSubview:_myTableView];
        
        [_myTableView registerClass:[TourisEvaluateCell class] forCellReuseIdentifier:cellIdeitifier];
        
        [self.myTableView setEstimatedRowHeight:100];
    }
    
    return self;
}

- (void)setTourisEvaluate:(NSArray *)tourisEvaluate{
    _tourisEvaluates = tourisEvaluate;
    
    _cacheRowHeight = [NSMutableDictionary new];
    [self.myTableView reloadData];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tourisEvaluates.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *key = [NSString stringWithFormat:@"row%ld",indexPath.row];
    
    CGFloat height = [TourisEvaluateCell cellWithRowHeight:_tourisEvaluates[indexPath.row]];
    
    if (height == 0) {
        [_cacheRowHeight setObject:@(height) forKey:key];
    }
    
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TourisEvaluateCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdeitifier];
    
    if (cell == nil) {
        cell = [[TourisEvaluateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdeitifier];
    }
    
    cell.tourisEvaluate = _tourisEvaluates[indexPath.row];
    
    return cell;
}

@end
