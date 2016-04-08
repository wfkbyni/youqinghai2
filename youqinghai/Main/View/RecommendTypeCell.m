//
//  RecommendTypeCell.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/23.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "RecommendTypeCell.h"

@interface RecommendTypeCell()

@property (weak, nonatomic) IBOutlet UIButton *imgUrlBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *introduceLab;
@property (weak, nonatomic) IBOutlet UILabel *partakeLab;
@property (weak, nonatomic) IBOutlet UIView *partakeView;
@end

@implementation RecommendTypeCell

- (void)awakeFromNib {
    // Initialization code
    
    [self.imgUrlBtn viewWithCornerRadius:5];
    [self.partakeView viewWithCornerRadius:10];
    
    UIColor *color = [UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.00];
    [self.introduceLab setTextColor:color];
    [self.partakeLab setTextColor:color];
    
    self.imgUrlBtn.userInteractionEnabled = NO;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setRecommend:(Recommend *)recommend{
    
    [self.imgUrlBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:recommend.imgUrl] forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        image = [self.imgUrlBtn clipImage:image toSize:self.imgUrlBtn.frame.size];
        [self.imgUrlBtn setBackgroundImage:image forState:UIControlStateNormal];
    }];
    
    self.titleLab.text = recommend.title;
    
    self.introduceLab.text = recommend.introduce;
    
    self.partakeLab.text = [NSString stringWithFormat:@"参与:%@",recommend.partake];
}

@end
