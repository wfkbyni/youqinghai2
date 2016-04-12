//
//  ZUserModel.m
//  youqinghai
//
//  Created by snailz on 16/3/28.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "ZUserModel.h"

@implementation ZUserModel
+(instancetype)shareUserModel
{
    static ZUserModel *userModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{   
        userModel = [[self alloc]init];
    });
    return userModel;
}
-(RACSignal *)getUserDataWithPhone:(NSString*)phone andPassWord:(NSString*)passWord
{
    RACSignal *signal =  [[RequestBaseAPI standardAPI] userLoginWithPhone:phone?phone:[ZUserModel shareUserModel].phone withPassWord:passWord?passWord:[ZUserModel shareUserModel].passWord ];
    [signal subscribeNext:^(id x) {
        NSLog(@"%@",x);
        
        NSDictionary *dic =  [NSJSONSerialization JSONObjectWithData:[((NSString *)x) dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        [[ZUserModel shareUserModel] mj_setKeyValues:dic];
         [ZUserModel shareUserModel].passWord = passWord?passWord:[ZUserModel shareUserModel].passWord;
    }];
    return signal;
}
@end
