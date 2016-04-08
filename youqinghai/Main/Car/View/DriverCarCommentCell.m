//
//  DriverCarCommentCell.m
//  youqinghai
//
//  Created by 舒永超 on 16/4/4.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "DriverCarCommentCell.h"

@interface DriverCarCommentCell()

@property (weak, nonatomic) IBOutlet UIButton *headUrlView;
@property (weak, nonatomic) IBOutlet UILabel *nicknameView;
@property (weak, nonatomic) IBOutlet UILabel *evatTimeView;
@property (weak, nonatomic) IBOutlet UIImageView *scroeView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabView;

@end

@implementation DriverCarCommentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setEav:(Eav *)eav{
    [self.headUrlView sd_setBackgroundImageWithURL:[NSURL URLWithString:eav.headUrl] forState:UIControlStateNormal];
    [self.nicknameView setText:eav.nickname];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[eav.evatTime longLongValue] / 1000];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *time = [df stringFromDate:date];
    
    [self.evatTimeView setText:time];
    
    self.contentLabView.text = eav.content;
}

@end
