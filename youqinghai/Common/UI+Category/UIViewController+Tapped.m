//
//  UIViewController+Tapped.m
//  Living
//
//  Created by mouxiaochun on 4/6/15.
//  Copyright (c) 2015 时代联创. All rights reserved.
//

#import "UIViewController+Tapped.h"
#import <objc/runtime.h>
static char key_Keyboard;
static char key_TapGesture;

static NSString * key_KeyboardWillShow = @"key_KeyboardWillShow";

@implementation UIViewController(Tapped)


- (void) addNotifications {

    static char key_Tapped;
    id loaded = objc_getAssociatedObject(self, &key_Tapped);
    if (loaded == nil)
    {
        self.view.userInteractionEnabled = YES;
        
        objc_setAssociatedObject(self, &key_Tapped, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        NSNotificationCenter *nCenter = [NSNotificationCenter defaultCenter];
        [nCenter addObserver:self selector:@selector(keyboardAppear) name:UIKeyboardDidShowNotification object:nil];
        [nCenter addObserver:self selector:@selector(keyboardDisappear) name:UIKeyboardWillHideNotification object:nil];
        [nCenter addObserver:self selector:@selector(keyboardWillAppear) name:UIKeyboardWillShowNotification object:nil];
        [nCenter addObserver:self selector:@selector(keyboardWillDisappear) name:UIKeyboardWillHideNotification object:nil];
        
        
    }
}

/**
 *  键盘打开/关闭
 *
 *  @param onBlock
 */

-(void)setKeyboardDidBlock:(void (^)(BOOL onOrOff))keyboardDidBlock{

    [self addNotifications];
    objc_setAssociatedObject(self, &key_Keyboard, keyboardDidBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void (^)(BOOL onOrOff))keyboardDidBlock{

    return objc_getAssociatedObject(self, &key_Keyboard);
}


-(void)setKeyboardWillBlock:(void (^)(BOOL onOrOff))keyboardWillBlock{
    [self addNotifications];
    objc_setAssociatedObject(self, (__bridge const void *)(key_KeyboardWillShow), keyboardWillBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void (^)(BOOL onOrOff))keyboardWillBlock{
    
    return objc_getAssociatedObject(self, (__bridge const void *)(key_KeyboardWillShow));
}


-(UITapGestureRecognizer *)tap{

    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &key_TapGesture);
    if (!gesture) {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(releaseKeyboard)];
        objc_setAssociatedObject(self, &key_TapGesture,gesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return gesture;
}

-(void)releaseKeyboard{
    [self.view endEditing:YES];
    
}
-(void)keyboardDisappear{

    if (self.keyboardDidBlock) {
        [self.view removeGestureRecognizer:self.tap];
         self.keyboardDidBlock(NO);
    }
}

-(void)keyboardAppear{
    if (self.keyboardDidBlock) {
        
        [self.view addGestureRecognizer:self.tap];
        self.keyboardDidBlock(YES);
    }
}

-(void)keyboardWillAppear {

    if (self.keyboardWillBlock) {
        [self.view addGestureRecognizer:self.tap];
        self.keyboardWillBlock(YES);
    }
}

- (void) keyboardWillDisappear {
    if (self.keyboardWillBlock) {
        [self.view removeGestureRecognizer:self.tap];
        self.keyboardWillBlock (NO);
    }
    
}

@end
