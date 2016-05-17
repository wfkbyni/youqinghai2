//
//  KMMessagView.m
//  KMMessageBox
//
//  Created by fengxi on 15-1-28.
//  Copyright (c) 2015年 KeithMorning. All rights reserved.
//
#define K_right_padding 44.0
#import "KMMessagView.h"
#import "KMPlaceholderTextView.h"
@interface KMMessagView()
{
    CGFloat maxy;//goodmessagebox的最大y值
}

@property (nonatomic,copy)void(^sendText)(NSString *);
@end
@implementation KMMessagView
-(instancetype)initWithFrame:(CGRect)frame PlaceText:(NSString *)placeText PlaceColor:(UIColor *)placeColor{
    self=[super initWithFrame:frame];
    if (self) {
        //添加顶分割线
       //[self addSubview:[self addUpline]];
        //添加输入框
        CGRect textFrame=CGRectMake(0, 6,self.frame.size.width-50, 33);
        _Inputview=[[KMPlaceholderTextView alloc]initWithFrame:textFrame PlaceText:placeText PlaceColor:placeColor];
        _Inputview.delegate=self;
        [_Inputview TextViewSizeChange:^(CGSize size) {
            [self TextViewDidChange:size];
            
        }];
        _Inputview.returnKeyType = UIReturnKeySend;
        _Inputview.font=[UIFont systemFontOfSize:14.0];
        [self addSubview:_Inputview];
        //添加发送按钮
        CGRect buttonFram=CGRectMake(self.frame.size.width-K_right_padding - 20, 6, 50, 33);
        _sendButton=[[UIButton alloc]initWithFrame:buttonFram];
        //[_sendButton setBackgroundImage:[UIImage imageNamed:@"send_arrow_left@2x.png"] forState:UIControlStateNormal];
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
        [_sendButton setTitleColor:[UIColor colorWithRed:0.04 green:0.69 blue:0.78 alpha:1.00] forState:UIControlStateNormal];
        [_sendButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_sendButton];
  
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
        maxy = [UIScreen mainScreen].bounds.size.height - 49;
        self.frame=CGRectMake(0, self.frame.origin.y-self.frame.size.height, self.frame.size.width, self.frame.size.height);//在底部显示
        self.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0];
    }
    
    return self;
}

#pragma mark 添加上边line
-(UIView *)addUpline{
    CGRect frame=CGRectMake(10, 0, CGRectGetWidth([UIScreen mainScreen].bounds)-20, 1);
    UIView *line=[[UIView alloc]initWithFrame:frame];
    [line setBackgroundColor:[UIColor lightGrayColor]];
    return line;
}
#pragma mark 根据输入框高度调整sendbutton位置
-(void)resetSendButtonPostion:(CGSize)size{
    CGFloat height=size.height/2;
    CGPoint center=_sendButton.center;
    center.y=height+6;
    [UIView animateWithDuration:1.0f animations:^{
          _sendButton.center=center;
    }];
  
}
#pragma mark 处理来自输入框的大小
-(void)TextViewDidChange:(CGSize)size{
    self.frame=CGRectMake(0, self.frame.origin.y, self.frame.size.width,size.height+6*2);
    self.frame=CGRectMake(0,maxy-(self.frame.size.height > 20 * 5 ? 20 * 5 - 5 : self.frame.size.height), self.frame.size.width, self.frame.size.height);
    _Inputview.frame=CGRectMake(0, 6, self.frame.size.width-K_right_padding - 10, size.height > 20 * 5 ? 20 * 5 : size.height);
    [_Inputview setContentSize:CGSizeMake(CGRectGetWidth(_Inputview.frame), size.height)];
    
    if (_Inputview.Textnil) {
        //[_sendButton setBackgroundImage:[UIImage imageNamed:@"send_arrow_left@2x.png"] forState:UIControlStateNormal];
          CGRect buttonFram=CGRectMake(self.frame.size.width-K_right_padding - 10, 6, 50, 33);
        _sendButton.frame=buttonFram;
    }else{
        //[_sendButton setBackgroundImage:[UIImage imageNamed:@"send_blue_arrow_left@2x.png"] forState:UIControlStateNormal];
        [self resetSendButtonPostion:size];
    }
}
#pragma mark sendbutton发送
-(void)sendMessage:(void (^)(NSString * text))inputText{
    if (inputText) {
        self.sendText=inputText;
    }
}
-(void)buttonClick{
    [self sendInputText];
}
-(void)sendInputText{
    if (_Inputview.Textnil) {
        return;
    }else{
        if(self.sendText){
        self.sendText(_Inputview.text);
        _Inputview.text=@"";
            
            [self TextViewDidChange:CGSizeMake(CGRectGetWidth(_Inputview.frame), 40.0f)];
        }
    }
}
#pragma mark 处理键盘显示通知
-(void)keyboardWillShow:(NSNotification *)notification{
 
    NSDictionary *userInfo=[notification userInfo];
    NSTimeInterval boardAnimationDuration=[[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect frame=[[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
    [UIView animateWithDuration:boardAnimationDuration delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGFloat keyBoardY=frame.origin.y;
        CGFloat keyBoardHeigh=frame.size.height;
        CGFloat sHeight = [UIScreen mainScreen].bounds.size.height;
        maxy= sHeight - keyBoardHeigh;
        CGRect frame=self.frame;
      
        BOOL isBottom = keyBoardY >= sHeight ?YES:NO;//键盘是否在底部
        CGFloat minusHeight = isBottom == NO?0 : (self.isHiddenBar?0:49);
       
        frame.origin.y=keyBoardY - CGRectGetHeight(self.frame) - minusHeight;//- 49
        self.frame=frame;
        
    } completion:^(BOOL finished) {
       
    }];
}

#pragma mark 处理退出键盘
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqual:@"\n"]) {
         [self sendInputText];
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
@end
