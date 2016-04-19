//
//  InsuranceTableViewCell.m
//  youqinghai
//
//  Created by 舒永超 on 16/4/19.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "InsuranceTableViewCell.h"

@interface InsuranceTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *cardNo;
@end

@implementation InsuranceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCardNoModel:(CardNo *)cardNoModel{
    self.name.text = cardNoModel.userName;
    self.cardNo.text = cardNoModel.cardNum;
}
@end
