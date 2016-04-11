//
//  DriverCarCommentTableViewCell.m
//  youqinghai
//
//  Created by 舒永超 on 16/4/4.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "DriverCarCommentTableViewCell.h"
#import "DriverCarCellFooterView.h"
#import "DriverCarCellHeaderView.h"
#import "DriverCarCommentCell.h"

@interface DriverCarCommentTableViewCell()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) DriverCarCellHeaderView *headerView;

@property (nonatomic, strong) DriverCarCellFooterView *footerView;

@property (nonatomic, strong) UITableView *myTableView;
@end

@implementation DriverCarCommentTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addSubview:self.headerView];
        
        [self addSubview:self.myTableView];
        
        [self addSubview:self.footerView];
    }
    
    return self;
}

-(void)setEvalist:(NSArray *)evalist{
    _evalist = evalist;
    
    float height = 0;
    if (evalist.count > 0) {
        for (NSInteger i = 0; i < MIN(3, evalist.count); i ++) {
            height += [DriverCarCommentTableViewCell calcCellHeight:evalist[i]];
        }
    }
    height += 50;
    CGRect frame = self.myTableView.frame;
    frame.size.height = height;
    self.myTableView.frame = frame;
    
    [self.myTableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [[self class] calcCellHeight:_evalist[indexPath.row]];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _evalist.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DriverCarCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.eav = _evalist[indexPath.row];
    
    CGRect frame  = self.footerView.frame;
    frame.origin.y = CGRectGetHeight(self.frame) - CGRectGetHeight(self.footerView.frame);
    self.footerView.frame = frame;
    
    return cell;
}


- (DriverCarCellHeaderView *)headerView{
    
    if (!_headerView) {
        _headerView = [[DriverCarCellHeaderView alloc] initWithFrame:CGRectZero withImageName:@"detail_comment" withTitle:@"游客评价"];
    }
    
    return _headerView;
}

- (DriverCarCellFooterView *)footerView{
    if (!_footerView) {
        _footerView = [[DriverCarCellFooterView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.myTableView.frame) + 5, kScreenSize.width, 40) withTitle:@"全部评价>>" withIsShowLine:NO];
    }
    return _footerView;
}

- (UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, kScreenSize.width, 0) style:UITableViewStylePlain];
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
        [_myTableView setScrollEnabled:NO];
        [_myTableView registerNib:[UINib nibWithNibName:@"DriverCarCommentCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    }
    return _myTableView;
}

+(float)calcCellHeight:(Eav *)eav{
    
    float height = 8 * 3 + 46;
    
    height += [eav.content calHeightWithWidth:kScreenSize.width - 70 withFontSize:14];
    
    return height;
}

@end
