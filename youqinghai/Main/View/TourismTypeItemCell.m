//
//  TourismTypeItemCell.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/23.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "TourismTypeItemCell.h"

@interface TourismTypeItemCell()

@property (weak, nonatomic) IBOutlet UIButton *typeImgUrlBtn;
@property (weak, nonatomic) IBOutlet UILabel *typeNameLab;
@end

@implementation TourismTypeItemCell

-(void)awakeFromNib{
    [self viewWithCornerRadius:5];
    self.typeImgUrlBtn.userInteractionEnabled = NO;
}

-(void)setTourismType:(TourismType *)tourismType{
 

    [self.typeImgUrlBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:tourismType.typeImgUrl] forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        image = [self.typeImgUrlBtn clipImage:image toSize:self.typeImgUrlBtn.frame.size];
        [self.typeImgUrlBtn setBackgroundImage:image forState:UIControlStateNormal];
    }];
    
    
    NSString *typeName = [tourismType.typeName stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    [self.typeNameLab setText:typeName];
}

@end
