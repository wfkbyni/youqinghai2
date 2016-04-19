//
//  InsuranceTableViewCell.h
//  youqinghai
//
//  Created by 舒永超 on 16/4/19.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InsuranceTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *deleteInsuranceBtn;
@property (nonatomic, strong) CardNo *cardNoModel;

@end
