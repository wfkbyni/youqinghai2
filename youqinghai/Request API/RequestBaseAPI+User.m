//
//  RequestBaseAPI+User.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/20.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "RequestBaseAPI+User.h"
#import "GTMBase64+Des.h"
#import "DeviceUtility.h"
NSString *const userRegister = @"app/user/userRegister";
NSString *const userLogin = @"app/user/userLogin";
NSString *const userForGet = @"app/user/getForgetPassword";
@implementation RequestBaseAPI (User)

-(RACSignal *)userRegisterWithPhone:(NSString *)phone withPassword:(NSString *)password withCode:(NSString *)code withType:(UserRegisterType)type{
    
    NSString *param = [NSString stringWithFormat:@"server=%@&phone=%@&password=%@&code=%@&type=%@",userRegister,phone,password,code,@(type)];
     NSLog(@"=== %@",param);
    param = [GTMBase64 desEncrypt:param];
   
    //NSString *str = @"server=app/homepage/getHomePageData&mark=1&pageIndex=1&pageSize=20";
   // param = [DeviceUtility encryptUseDES:str];
    //NSLog(@"+++ %@",param);

    
    return [self requestWithType:RequestAPITypePost params:param];
}
-(RACSignal *)userLoginWithPhone:(NSString *)phone withPassWord:(NSString *)password
{
    NSString *param = [NSString stringWithFormat:@"server=%@&phone=%@&password=%@",userLogin,phone,password];
    param = [GTMBase64 desEncrypt:param];
    return [self requestWithType:RequestAPITypePost params:param];
}
-(RACSignal *)userForgetWithPhone:(NSString *)phone withPassWord:(NSString *)password withsmscode:(NSString *)smscode withtype:(UserRegisterType)type
{
    NSString *param = [NSString stringWithFormat:@"server=%@&phone=%@&password=%@&smscode=%@&type=%@",userForGet,phone,password,smscode,@(type)];
    NSLog(@"=== %@",param);
    param = [GTMBase64 desEncrypt:param];
    
 
    
    return [[self requestWithType:RequestAPITypePost params:param]map:^id(ResponseBaseData *data) {
        if (!data.result_data) {
            data.result_data = @"";
        }
        return data.result_data;
    }];
}
@end
