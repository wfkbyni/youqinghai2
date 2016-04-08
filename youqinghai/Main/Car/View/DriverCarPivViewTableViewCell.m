//
//  DriverCarPivViewTableViewCell.m
//  youqinghai
//
//  Created by 舒永超 on 16/4/4.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "DriverCarPivViewTableViewCell.h"
#import "DriverCarCellHeaderView.h"
#import "DriverCarCellFooterView.h"

@interface DriverCarPivViewTableViewCell()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) DriverCarCellHeaderView *headerView;

@property (nonatomic, strong) DriverCarCellFooterView *footerView;

@property (nonatomic, strong) UICollectionView *myCollectionView;

@end

@implementation DriverCarPivViewTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addSubview:self.headerView];
        
        [self addSubview:self.myCollectionView];
        
        [self addSubview:self.footerView];
    }
    
    return self;
}

- (void)setImgList:(NSArray *)imgList{
    _imgList = imgList;
    [self.myCollectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _imgList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    UIImageView *imageView = [cell viewWithTag:100];
    if (!imageView) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (kScreenSize.width - 20) / 3, 80)];
        [cell.contentView addSubview:imageView];
    }
    
    Img *img = _imgList[indexPath.row];
    
    NSURL *url = [NSURL URLWithString:img.imgUrl];
    
    [imageView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        imageView.image = [imageView clipImage:image toSize:imageView.frame.size];
    }];
    
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((kScreenSize.width - 20) / 3, 80);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (DriverCarCellHeaderView *)headerView{
    
    if (!_headerView) {
        _headerView = [[DriverCarCellHeaderView alloc] initWithFrame:CGRectZero withImageName:@"collection_off" withTitle:@"司机/车辆图片"];
    }
    
    return _headerView;
}

- (DriverCarCellFooterView *)footerView{
    if (!_footerView) {
        _footerView = [[DriverCarCellFooterView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.myCollectionView.frame) + 5, kScreenSize.width, 40) withTitle:@"全部图片>>" withIsShowLine:YES];
    }
    return _footerView;
}

- (UICollectionView *)myCollectionView{
    if (!_myCollectionView) {
        UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _myCollectionView  = [[UICollectionView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.headerView.frame), kScreenSize.width - 20, 80)
                                               collectionViewLayout:flowLayout];
        [_myCollectionView setShowsHorizontalScrollIndicator:NO];
        [_myCollectionView setBackgroundColor:[UIColor whiteColor]];
        _myCollectionView.dataSource = self;
        _myCollectionView.delegate = self;
        
        [_myCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _myCollectionView;
}

@end
