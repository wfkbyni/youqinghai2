//
//  ZTextViewCell.h
//  youqinghai
//
//  Created by snailz on 16/4/6.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZOpinionViewController.h"
#define ImageH (SCREEN_WIDTH-50)/4
#define imageViewH 170
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
typedef void (^TextBlcok)(NSString*);
typedef void(^imageBlcok)(NSMutableArray*);
@interface ZTextViewCell : UITableViewCell<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *placeholder;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewheight;
@property(strong,nonatomic)NSString* strText;
@property(strong,nonatomic)TextBlcok TextBlcok;
@property(strong,nonatomic)imageBlcok imageBlcok;
@property(strong,nonatomic)NSString* photo;
@property(nonatomic,weak)UIViewController *controller;
@property(nonatomic,strong)NSMutableArray *images;//
@end
