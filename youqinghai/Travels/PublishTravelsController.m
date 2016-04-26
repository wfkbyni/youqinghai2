//
//  PublishTravelsController.m
//  youqinghai
//
//  Created by 舒永超 on 16/4/26.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "PublishTravelsController.h"
#import "YYTextView.h"

@interface PublishTravelsController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>{
    NSMutableArray *collectionData;
}

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) YYTextView *yyTextView;
@property (nonatomic, strong) UICollectionView *myCollectionView;

@end

@implementation PublishTravelsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"发布";
    
    [self.view setBackgroundColor:[UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1.00]];
    
    [self navBarButtonItem];
    
    [self commonTableView];
 
    collectionData = [NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"",@"",@"", nil];
}

- (void)navBarButtonItem{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(submitAction:)];
}

- (void)commonTableView{
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, kScreenSize.width, CGRectGetHeight(self.view.bounds))];
    [_myTableView setScrollEnabled:NO];
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    
    [_myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [_myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell2"];
    
    [self.view addSubview:_myTableView];
}

- (void)cancelAction:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)submitAction:(id)sender{
    [self.view makeToast:@"开发中"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 120.0f;
    }
    return 120.0f;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        
        _yyTextView = [cell viewWithTag:1000];
        if (!_yyTextView) {
            _yyTextView = self.yyTextView;
            _yyTextView.tag = 1000;
            [cell.contentView addSubview:_yyTextView];
        }
        
        return cell;
        
    }else if(indexPath.row == 1){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        _myCollectionView = [cell viewWithTag:2000];
        if (!_myCollectionView) {
            _myCollectionView = self.myCollectionView;
            _myCollectionView.tag = 2000;
            [cell.contentView addSubview:_myCollectionView];
        }
        
        return cell;
    }
    return nil;
}

- (YYTextView *)yyTextView{
    if (!_yyTextView) {
        _yyTextView = [[YYTextView alloc] initWithFrame:CGRectMake(10, 0, kScreenSize.width - 20, 120)];
        [_yyTextView setPlaceholderText:@"说说您想给大家分享的内容吧!"];
        [_yyTextView setPlaceholderFont:[UIFont systemFontOfSize:14.0f]];
        [_yyTextView setFont:[UIFont systemFontOfSize:14.0f]];
    }
    
    return _yyTextView;
}

- (UICollectionView *)myCollectionView{
    if (!_myCollectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake([self viewWidth], [self viewWidth]);
        layout.minimumInteritemSpacing = 5;
        layout.minimumLineSpacing = 5;
        
        _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 0) collectionViewLayout:layout];
        [_myCollectionView setBackgroundColor:[UIColor whiteColor]];
        [self changeCollectionViewHeight];
        _myCollectionView.dataSource = self;
        _myCollectionView.delegate = self;
        
        [_myCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collectionViewCell"];
    }
    
    return _myCollectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return collectionData.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell" forIndexPath:indexPath];
    
    UIImageView *imageView = [cell viewWithTag:1000 + indexPath.row];
    if (!imageView) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [self viewWidth], [self viewWidth])];
        imageView.tag = 1000 + indexPath.row;
        [cell.contentView addSubview:imageView];
    }
    
    [imageView setBackgroundColor:[UIColor colorWithRed:arc4random_uniform(255.0f) / 255.0f green:arc4random_uniform(255.0f) / 255.0f blue:arc4random_uniform(255.0f) / 255.0f alpha:1]];
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

#define rowCount 5
#define lineSpacing 5
- (CGFloat)viewWidth{
    
    CGFloat width = (kScreenSize.width - lineSpacing * (rowCount + 1)) / rowCount;
    
    return width;
}

- (void)changeCollectionViewHeight{
    NSInteger row = collectionData.count % rowCount == 0 ? collectionData.count / rowCount : collectionData.count / rowCount + 1;
    
    CGRect frame = _myCollectionView.frame;
    frame.size.height = row * [self viewWidth] + (row + 1) * lineSpacing;
    _myCollectionView.frame = frame;
}
@end
