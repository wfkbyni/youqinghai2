//
//  ZTextViewCell.h
//  youqinghai
//
//  Created by snailz on 16/4/6.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^TextBlcok)(NSString*);

@interface ZTextViewCell : UITableViewCell<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *textView;
@property (weak, nonatomic) IBOutlet UILabel *placeholder;
@property(strong,nonatomic)NSString* strText;
@property(strong,nonatomic)TextBlcok TextBlcok;

@end
