//
//  TourisEvaluateCell.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/28.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "TourisEvaluateCell.h"

#import "TourismTypeItemCell.h"

@interface TourisEvaluateCell()

@property (strong, nonatomic) UIImageView *userImgView;
@property (strong, nonatomic) UILabel *userNameLab;
@property (strong, nonatomic) UILabel *evatTimeLab;
@property (strong, nonatomic) UILabel *contentLab;

@property (nonatomic, strong) NSArray *listImages;

@property (nonatomic, strong) NSMutableArray *imageViewArray;

@end

#define identifier @"collectionViewCell"
#define leftWidth 60
#define picWidth ((kScreenSize.width - leftWidth) - 4 * 10) / 3

@implementation TourisEvaluateCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 头像
        _userImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 48, 48)];
        [_userImgView viewWithCornerRadius:CGRectGetWidth(_userImgView.frame) / 2];
        
        // 名字
        _userNameLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_userImgView.frame) + 10, 10, 100, 21)];
        [_userNameLab setFont:[UIFont systemFontOfSize:15.0f]];
        
        // 时间
        _evatTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_userNameLab.frame), 10, kScreenSize.width - 10, 21)];
        [_evatTimeLab setFont:[UIFont systemFontOfSize:15.0f]];
        
        // 内容
        _contentLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_userImgView.frame) + 10, CGRectGetMaxY(_userNameLab.frame) + 10, kScreenSize.width - 60 - 10, 0)];
        [_contentLab setNumberOfLines:0];
        [_contentLab setFont:[UIFont systemFontOfSize:14.0f]];
        
        [self.contentView addSubview:_userImgView];
        [self.contentView addSubview:_userNameLab];
        [self.contentView addSubview:_evatTimeLab];
        [self.contentView addSubview:_contentLab];
        
        _imageViewArray = [[NSMutableArray alloc] initWithCapacity:6];
        // 添加图片
        for (NSInteger i = 0; i < 6; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
            imageView.tag = 100 + i;
            imageView.hidden = YES;
            [self.contentView addSubview:imageView];
            
            [_imageViewArray addObject:imageView];
        }
        
    }
    return self;
}

-(void)setTourisEvaluate:(TourisEvaluate *)tourisEvaluate{
    [self.userImgView sd_setImageWithURL:[NSURL URLWithString:tourisEvaluate.userImgUrl]];
    [self.userNameLab setText:tourisEvaluate.userName];
    [self.contentLab setText:tourisEvaluate.content];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[tourisEvaluate.evatTime longLongValue] / 1000];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *time = [df stringFromDate:date];
    
    [self.evatTimeLab setText:time];
    
    CGRect frame = self.contentLab.frame;
    frame.size.height = [tourisEvaluate.content calHeightWithWidth:kScreenSize.width - leftWidth withFontSize:14.0f];
    self.contentLab.frame = frame;
    
    _listImages = tourisEvaluate.listImage;
    
    for (NSInteger i = _listImages.count; i < _imageViewArray.count; i++) {
        UIImageView *imageView = _imageViewArray[i];
        imageView.hidden = YES;
    }
    
    if (_listImages.count == 0) {
        return;
    }
    
    [_listImages enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger columnIndex = idx % 3;
        NSInteger rowIndex = idx / 3;
        
        UIImageView *imageView = _imageViewArray[idx];
        imageView.hidden = NO;
        
        CGRect frame = CGRectMake(columnIndex * (picWidth + 10) + CGRectGetMaxX(_userImgView.frame) + 10 , rowIndex * (picWidth + 10) + CGRectGetMaxY(_contentLab.frame) + 10, picWidth, picWidth);
        imageView.frame = frame;
        
        NSString *imgUrl = obj[@"imgUrl"];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"collection_off"]];
    }];
    
    [self layoutIfNeeded];
}

/**
 *  @brief 计算图片的高度
 *
 *  @param picsData <#picsData description#>
 *
 *  @return <#return value description#>
 */
+ (CGFloat)calPicHeightWithPicsData:(NSArray *)picsData{
    
    CGFloat height = 0;
    
    if (picsData.count > 0) {
        height += 10;   // 图片到内容距离
        
        if (picsData.count <= 3) {
            height += picWidth;
        }else{
            height += picWidth * 2 + 10;
        }
    }
    
    return height;
}

/**
 *  @brief 计算row的高度
 *
 *  @param tourisEvaluate <#tourisEvaluate description#>
 *
 *  @return <#return value description#>
 */
+ (CGFloat)cellWithRowHeight:(TourisEvaluate *)tourisEvaluate{
    
    CGFloat height = 10;    // 名字到上边距的距离
    
    height += 21; // 名字的高度
    
    height += 10; // 内容距离名字的高度
    
    height += [tourisEvaluate.content calHeightWithWidth:kScreenSize.width - leftWidth withFontSize:14.0f]; // 内容的高度
    height += [self calPicHeightWithPicsData:tourisEvaluate.listImage];    // 图片的高度
    
    height += 10;   // 图片到底边的距离
    
    return height;
}

@end
