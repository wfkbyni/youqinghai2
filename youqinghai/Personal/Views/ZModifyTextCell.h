//
//  ZModifyTextCell.h
//  youqinghai
//
//  Created by snailz on 16/3/30.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^TextBlcok)(NSString*);

@interface ZModifyTextCell : UITableViewCell<UITextFieldDelegate>
/**
 *  title
 */
@property (weak, nonatomic) IBOutlet UILabel *lableText;
@property (weak, nonatomic) IBOutlet UITextField *fieldText;
@property(strong,nonatomic)TextBlcok TextBlcok;
@end
