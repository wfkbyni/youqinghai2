//
//  TourismTypeCell.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/23.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "TourismTypeCell.h"
#import "TourismTypeItemCell.h"

#import "TouristroutesViewController.h"

@interface TourismTypeCell()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@end

#define identifier @"collectionViewCell"

@implementation TourismTypeCell

- (void)awakeFromNib {
    // Initialization code
    
    [self.myCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([TourismTypeItemCell class]) bundle:nil] forCellWithReuseIdentifier:identifier];
    
    self.myCollectionView.dataSource = self;
    self.myCollectionView.delegate = self;
    
    [self.myCollectionView reloadData];
    
    [self.contentView viewWithCornerRadius:5];
}

- (void)setTourismTypes:(NSArray *)tourismTypes{
    _tourismTypes = tourismTypes;
    [self.myCollectionView reloadData];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.tourismTypes.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TourismTypeItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.tourismType = self.tourismTypes[indexPath.row];
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
    
    cell.layer.borderColor = [UIColor colorWithRed:arc4random_uniform(255.0f) / 255.0f green:arc4random_uniform(255.0f) / 255.0f blue:arc4random_uniform(255.0f) / 255.0f alpha:1].CGColor;
    cell.layer.masksToBounds = YES;
    
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TourismType *tourismType = self.tourismTypes[indexPath.row];
    
    TouristroutesViewController *controller = [[TouristroutesViewController alloc] init];
    controller.tourismType = tourismType;
    
    [self.navigationController pushViewController:controller animated:YES];
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(150, 100);
}

@end
